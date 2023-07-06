//
//  TrackOptionsViewModel.swift
//  My Spotify
//
//  Created by Krunal Patel on 10/07/23.
//

import Alamofire

class TrackOptionsViewModel {
    
    // MARK: - Vars & Lets
    let errorMessage = Dynamic<String>("")
    let isLiked = Dynamic<Bool>(false)
    let reloadOptions = Dynamic<Void>(())
    let track = Dynamic<Track?>(nil)
    
    // MARK: - Methods
    func getTrackDetails(trackId: String) {
        
        APIManager.shared.call(type: .track(id: trackId)) { [weak self](result: Result<Track, CustomError>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                self.track.value = response
                self.getOptions()
            case .failure(let error):
                self.errorMessage.value = error.body
            }
        }
    }
    
    private func getOptions() {
        checkLike()
        reloadOptions.fire()
    }
    
    private func checkLike() {
        guard let trackId = track.value?.id else { return }
        
        let params = [
            "ids": trackId
        ]
        
        APIManager.shared.call(type: .checkLike, params: params) { [weak self](result: Result<[Bool], CustomError>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                self.isLiked.value = response.first ?? false
            case .failure(let error):
                self.errorMessage.value = error.body
                break
            }
        }
    }
    
    func toggleLike(isLike: Bool) {
        guard let trackId = track.value?.id else { return }
        
        let params = [
            "ids": [trackId]
        ]
        
        APIManager.shared.call(type: isLike ? .likeTrack : .dislikeTrack, params: params) { [weak self] (result: Result<DefaultCodable, CustomError>) in
            guard let self = self else { return }
            
            switch result {
            case .success:
                self.isLiked.value = isLike
                self.reloadOptions.fire()
            case .failure(let error):
                if (error.body == APIError.noData) {
                        self.isLiked.value = isLike
                    self.reloadOptions.fire()
                } else {
                    self.errorMessage.value = error.body
                }
            }
        }
    }
}
