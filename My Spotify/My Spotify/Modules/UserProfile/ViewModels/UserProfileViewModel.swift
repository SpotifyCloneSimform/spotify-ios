//
//  UserPRofileViewModel.swift
//  My Spotify
//
//  Created by Krunal Patel on 11/07/23.
//

import UIKit

class UserProfileViewModel {
    
    // MARK: - Lets
    let errorMessage = Dynamic<String>("")
    let isLoading = Dynamic<Bool>(false)
    let userProfile = Dynamic<UserProfile?>(nil)
    let userId = KeychainHelper.shared.userId
    let profileItems = Dynamic<[ProfileDisplayItem]>([])
    let itemUpdate = Dynamic<IndexPath>(.init(index: .zero))
    
    // MARK: - Methods
    func getAuthorizedUserProfile() {
        APIManager.shared.call(type: .authenticatedUserProfile) { [weak self] (result: Result<UserProfile, CustomError>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                self.userProfile.value = response
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
            self.isLoading.value = false
        }
    }
    
    func getProfileItems() {
        getPlaylists()
    }
    
    func getPlaylists() {
        APIManager.shared.call(type: .getUserPlaylists) { [weak self] (result: Result<DataItems<Playlist>, CustomError>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                if let items = response.items {
                    let usersPlaylists = items.filter { playlist in
                        playlist.owner?.id == self.userId
                    }.map { playlist in
                        return ProfileItem(id: playlist.id,image: playlist.images?.first?.url, name: playlist.name, ownerName: playlist.owner?.name)
                    }
                    self.profileItems.value.append(ProfileDisplayItem(title: "Playlists", items: usersPlaylists))
                    usersPlaylists.forEach {
                        if let id = $0.id {
                            self.getPlaylistInfo(playlistId: id)
                        }
                    }
                    self.profileItems.fire()
                }
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getPlaylistInfo(playlistId: String) {
        APIManager.shared.call(type: .playlist(id: playlistId)) { [weak self] (result: Result<Playlist, CustomError>)in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                if let sectionIndex = self.profileItems.value.firstIndex(where: { $0.title == "Playlists" }),
                   let itemIndex = self.profileItems.value[sectionIndex].items.firstIndex(where: { $0.id == playlistId}) {
                    let playlist = self.profileItems.value[sectionIndex].items[itemIndex]
                    playlist.artists = response.tracks?.items?.first?.track?.artists?.compactMap { $0.name }
                    playlist.followers = response.followers?.total ?? 0
                    self.itemUpdate.value = IndexPath(row: itemIndex, section: sectionIndex)
                }
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func logout() {
        KeychainHelper.shared.clearData(keys: [.userId, .accessToken, .refreshToken])
    }
}
