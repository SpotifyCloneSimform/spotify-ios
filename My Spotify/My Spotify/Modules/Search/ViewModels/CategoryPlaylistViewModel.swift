//
//  CategoryPlaylistViewModel.swift
//  My Spotify
//
//  Created by Krunal Patel on 12/07/23.
//

class CategoryPlaylistViewModel {
    
    // MARK: - Vars & Lets
    let errorMessage = Dynamic<String>("")
    let playlists = Dynamic<[Playlist]>([])
    
    // MARK: - Methods
    func getPlaylists(category: Category) {
        guard let id = category.id else { return }
        
        APIManager.shared.call(type: .categoryPlaylist(category: id)) { [weak self] (result: Result<CategoryPlaylists, CustomError>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                if let playlists = response.playlists?.items {
                    self.playlists.value = playlists.compactMap { $0 } 
                }
            case .failure(let error):
                self.errorMessage.value = error.body
            }
        }
    }
}
