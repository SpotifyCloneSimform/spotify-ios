//
//  ViewSongViewModel.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 11/07/23.
//

class ViewSongViewModel {
    
    // MARK: - Variables
    var isLiked = Dynamic<Bool>(false)
    var errorMessage = Dynamic<String>("")
    var reloadData = Dynamic<Void>(())
    
    func checkLike(trackId: String) {
        
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
    
    func updateLike(trackId: String, isLiked: Bool) {
        let params = [
            "ids": [trackId]
        ]
        
        APIManager.shared.call(type: isLiked ? .likeTrack : .dislikeTrack, params: params) { [weak self] (result: Result<DefaultCodable, CustomError>) in
            
            guard let self = self else {
                return
            }
            
            switch result {
            case .success:
                self.isLiked.value = isLiked
                self.reloadData.fire()
            case .failure(let error):
                if (error.body == APIError.noData) {
                    self.isLiked.value = isLiked
                    self.reloadData.fire()
                } else {
                    self.errorMessage.value = error.body
                }
            }
        }
    }
    
}
