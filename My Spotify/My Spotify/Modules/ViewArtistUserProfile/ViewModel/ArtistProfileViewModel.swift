//
//  ArtistProfileViewModel.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 10/07/23.
//

import Foundation

class ArtistProfileViewModel {
    
    // MARK: - variables
    var artist = Dynamic<ArtistProfile?>(nil)
    var failure = Dynamic<String>("")
    var artistTopTracks = Dynamic<ArtistTopTracks?>(nil)
    var topTrackFailure = Dynamic<String>("")
    var relatedArtist = Dynamic<RelatedArtists?>(nil)
    var relatedArtistFailure = Dynamic<String>("")
    
    func getArtistProfile(id: String) {
        APIManager.shared.call(type: .getArtist(id: id)) { [weak self] (result: Result<ArtistProfile, CustomError>) in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let artist):
                self.artist.value = artist
            case .failure(let error):
                self.failure.value = error.body
            }
        }
    }
    
    func getArtistTopTracks(id: String) {
        APIManager.shared.call(type: .getArtistTopTracks(id: id)) { [weak self] (result: Result<ArtistTopTracks, CustomError>) in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let topTracks):
                self.artistTopTracks.value = topTracks
            case .failure(let error):
                self.failure.value = error.body
            }
        }
    }
    
    func getRelatedArtists(id: String) {
        APIManager.shared.call(type: .getRelatedArtists(id: id)) { [weak self] (result: Result<RelatedArtists, CustomError>) in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let relatedArtist):
                self.relatedArtist.value = relatedArtist
            case .failure(let error):
                self.relatedArtistFailure.value = error.body
            }
        }
    }
    
}
