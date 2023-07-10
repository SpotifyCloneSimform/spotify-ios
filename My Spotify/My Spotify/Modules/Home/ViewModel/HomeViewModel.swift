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
            
            switch result {
            case .success(let playlists):
                let data = playlists.items?.map({ item in
                    HomeDisplayData(name: item.name, image: item.images?[0].url, url: item.uri)
                })
                self?.getAllData.value.append(HomeDisplay(sectionName: "Your Playlist", data: data))
                self?.getAllData.fire()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getAlbumbs() {
        APIManager.shared.call(type: .getUserAlbumbs) { [weak self] (result: Result<HomeAlbumb, CustomError>) in
            
            switch result {
            case .success(let albumbs):
                let data = albumbs.items?.map({ item in
                    HomeDisplayData(name: item.name, image: item.album?.images?[0].url, url: item.uri)
                })
                self?.getAllData.value.append(HomeDisplay(sectionName: "Your Songs", data: data))
                self?.getAllData.fire()
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func getFeaturedPlaylist() {
        APIManager.shared.call(type: .getFeaturedPlaylist) { [weak self] (result: Result<HomeFeatured, CustomError>) in
            
            switch result {
            case .success(let featuredPlaylist):
                let data = featuredPlaylist.playlists?.items?.map({ item in
                    HomeDisplayData(name: item.name, image: item.images?[0].url, url: item.uri)
                })
                self?.getAllData.value.append(HomeDisplay(sectionName: "Featured Playlist", data: data))
                self?.getAllData.fire()
            case .failure(let error):
                print(error)
            }
        }
    }
}
