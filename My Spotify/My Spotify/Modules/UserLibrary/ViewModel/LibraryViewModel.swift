//
//  LibraryViewModel.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 06/07/23.
//

import Foundation

struct LibraryDisplayData {
    let index: Int
    let isFiltered: Bool
    let type: LibraryItemType
    let data: [LibraryDisplay]
}

class LibraryViewModel {
  
    // MARK: - Variables
    var success = Dynamic<LibraryPlaylist?>(nil)
    var failure = Dynamic<String>("")
    var libraryInitalItems = Dynamic<[LibraryDisplayData]>([])
    
    func getAllLibraryData() {
        APIManager.shared.call(type: .getUserPlaylists) { [weak self] (result: Result<LibraryPlaylist, CustomError>) in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let libraryPlaylist):
                let data = libraryPlaylist.items?.map({ item in
                    LibraryDisplay(name: item.name, ownerDisplayName: item.owner?.displayName, image: item.images?[0].url, type: LibraryItemType.playlist)
                })
                self.libraryInitalItems.value.append(LibraryDisplayData(index: 0, isFiltered: false, type: LibraryItemType.playlist, data: data ?? []))
                self.libraryInitalItems.fire()
                
            case .failure(let error):
                self.failure.value = error.body
            }
        }
        
        APIManager.shared.call(type: .getAlbums) { [weak self] (result: Result<LibraryAlbum, CustomError>) in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let libraryAlbums):
                let data = libraryAlbums.items?.map({ items in
                    LibraryDisplay(name: items.album.name, ownerDisplayName: items.album.artists?[0].name, image: items.album.images?[0].url, type: LibraryItemType.album)
                })
                self.libraryInitalItems.value.append(LibraryDisplayData(index: 0, isFiltered: false, type: LibraryItemType.album, data: data ?? []))
                self.libraryInitalItems.fire()
                
            case .failure(let error):
                self.failure.value = error.body
            }
        }
        
        APIManager.shared.call(type: .getUserArtists) { [weak self] (result: Result<LibraryArtist, CustomError>) in
            
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let libraryArtists):
                let data = libraryArtists.artists?.items?.map({ item in
                    LibraryDisplay(name: item.name, ownerDisplayName: "", image: item.images?[0].url, type: LibraryItemType.artists)
                })
                self.libraryInitalItems.value.append(LibraryDisplayData(index: 0, isFiltered: false, type: LibraryItemType.artists, data: data ?? []))
                self.libraryInitalItems.fire()
                
            case .failure(let error):
                self.failure.value = error.body
            }
        }
    }
    
    // MARK: - Get library playlist
    func getLibraryPlaylist() {
        APIManager.shared.call(type: .getUserPlaylists) { [weak self] (result: Result<LibraryPlaylist, CustomError>) in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let libraryPlaylist):
              
                let data = libraryPlaylist.items?.map({ item in
                    LibraryDisplay(name: item.name, ownerDisplayName: item.owner?.displayName, image: item.images?[0].url, type: LibraryItemType.playlist)
                })
                
                self.libraryInitalItems.value.removeAll()
                self.libraryInitalItems.value.append(LibraryDisplayData(index: 0, isFiltered: true, type: LibraryItemType.playlist, data: data ?? []))
                self.libraryInitalItems.fire()
                
            case .failure(let error):
                self.failure.value = error.body
            }
        }
    }
    
    // MARK: - Get library artists
    func getLibraryArtists() {
        APIManager.shared.call(type: .getUserArtists) { [weak self] (result: Result<LibraryArtist, CustomError>) in
        
            guard let self = self else {
                return
            }
            switch result {
            case .success(let libraryArtists):
                
                let data = libraryArtists.artists?.items?.map({ item in
                    LibraryDisplay(name: item.name, ownerDisplayName: "", image: item.images?[0].url, type: LibraryItemType.artists)
                })
                self.libraryInitalItems.value.removeAll()
                self.libraryInitalItems.value.append(LibraryDisplayData(index: 0, isFiltered: false, type: LibraryItemType.artists, data: data ?? []))
                self.libraryInitalItems.fire()
                
            case .failure(let error):
                self.failure.value = error.body
            }
        }
    }
    
    // MARK: - Get user album
    func getLibraryAlbum() {
        APIManager.shared.call(type: .getAlbums) { [weak self] (result: Result<LibraryAlbum, CustomError>) in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let libraryAlbum):
                
                let data = libraryAlbum.items?.map({ items in
                    LibraryDisplay(name: items.album.name, ownerDisplayName: items.album.artists?[0].name, image: items.album.images?[0].url, type: LibraryItemType.album)
                })
                self.libraryInitalItems.value.removeAll()
                self.libraryInitalItems.value.append(LibraryDisplayData(index: 0, isFiltered: true, type: LibraryItemType.album, data: data ?? []))
                self.libraryInitalItems.fire()
                
            case .failure(let error):
                self.failure.value = error.body
            }
        }
    }
    
}
