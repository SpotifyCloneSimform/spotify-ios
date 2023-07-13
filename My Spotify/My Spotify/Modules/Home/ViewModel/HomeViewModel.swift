//
//  HomeViewModel.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 05/07/23.
//

import Foundation
class HomeViewModel {
    
    // MARK: - Variables
    var success = Dynamic<[Item]?>(nil)
    var fail = Dynamic<String>("")
    var getAllData = Dynamic<[HomeDisplay]>([])
    
    // MARK: - Get Playlist
    func getPlaylist() {
        APIManager.shared.call(type: .getUserPlaylists) {
            [weak self] (result: Result<HomePlaylist, CustomError>) in
            
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let playlists):
                let data = playlists.items?.map({ item in
                    HomeDisplayData(name: item.name, image: item.images?.first?.url, url: item.uri, ownerName: item.owner?.displayName, id: item.id, type: .playlist)
                })
                self.getAllData.value.append(HomeDisplay(sectionName: "Your Playlist", data: data))
                self.getAllData.fire()
            case .failure(let error):
                self.fail.value = error.body
            }
        }
    }
    
    // MARK: - Get Album of Song
    func getAlbumbs() {
        APIManager.shared.call(type: .getUserAlbumbs) { [weak self] (result: Result<HomeAlbumb, CustomError>) in
            
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let albumbs):
                let data = albumbs.items?.map({ item in
                    HomeDisplayData(name: item.name, image: item.album?.images?.first?.url, url: item.uri, ownerName: item.artists?.first?.name, id: item.album?.id, type: .album)
                })
                self.getAllData.value.append(HomeDisplay(sectionName: "Your Songs", data: data))
                self.getAllData.fire()
            case .failure(let error):
                self.fail.value = error.body
            }
        }
    }
    
    // MARK: - Get featured playlist
    func getFeaturedPlaylist() {
        APIManager.shared.call(type: .getFeaturedPlaylist) { [weak self] (result: Result<HomeFeatured, CustomError>) in
            
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let featuredPlaylist):
                let data = featuredPlaylist.playlists?.items?.map({ item in
                    HomeDisplayData(name: item.name, image: item.images?.first?.url, url: item.uri, ownerName: item.owner?.displayName, id: item.id, type: .playlist)
                })
                self.getAllData.value.append(HomeDisplay(sectionName: "Featured Playlist", data: data))
                self.getAllData.fire()
            case .failure(let error):
                self.fail.value = error.body
            }
        }
    }
}
