//
//  SearchHistoryViewModel.swift
//  My Spotify
//
//  Created by Krunal Patel on 06/07/23.
//

import Combine

class SearchHistoryViewModel {
    
    // MARK: - Vars & Lets
    let errorMessage = Dynamic<String>("")
    let searchItems = Dynamic<[SearchItem]>([])
    var offset = 728
    var limit = 10
    var hasMoreData = false
    
    // MARK: - Methods
    func search(query: String, isPagination: Bool = false) {
        guard !query.isEmpty else {
            hasMoreData = false
            searchItems.value = []
            return
        }
        
        if !isPagination {
            searchItems.value.removeAll()
            offset = 0
        }
        
        let params = [
            "q": query,
            "type": "\(ItemType.track),\(ItemType.album)",
            "offset": "\(offset)",
            "limit": "\(limit)",
            "include_external": "audio"
        ]
        
        APIManager.shared.call(type: .search, params: params) { [weak self] (result: Result<SearchResponse, CustomError>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                if let tracks = response.tracks?.items {
                    self.searchItems.value += tracks.map { track in
                        let artists = track.artists?.compactMap { $0.name }.joined(separator: ", ")
                        return SearchItem(image: track.album?.images?[0].url ?? "", name: track.name ?? "", description: "Song • \(artists ?? "")")
                    }
                }
                if let albums = response.albums?.items {
                    self.searchItems.value += albums.map { album in
                        let artists = album.artists?.compactMap { $0.name }.joined(separator: ", ")
                        return SearchItem(image: album.images?[0].url ?? "", name: album.name ?? "", description: "Album • \(artists ?? "")")
                    }
                }
                self.hasMoreData = response.tracks?.items?.isEmpty == false ||  response.albums?.items?.isEmpty == false
                self.searchItems.fire()
                self.setupNextPage()
            case .failure(let error):
                self.errorMessage.value = error.body
                break
            }
        }
    }
    
    func loadMoreResults(query: String) {
        search(query: query, isPagination: true)
    }
    
    private func setupNextPage() {
        guard hasMoreData else { return }
        offset += limit
    }
}
