//
//  RefreshTokenViewModel.swift
//  My Spotify
//
//  Created by Krunal Patel on 06/07/23.
//

class RefreshTokenViewModel {
    
    // MARK: - Vars
    var isSuccess = Dynamic<Bool>(true)
    
    // MARK: - Methods
    func callRefreshToken() {
        guard let refreshToken = KeychainHelper.shared.refreshToken else {
            isSuccess.value = false
            return
        }
        
        let params = [
            "grant_type": "refresh_token",
            "refresh_token": refreshToken]
        
        APIManager.shared.call(type: .refreshToken, params: params) { [weak self] (result: Result<AuthTokenResponse, CustomError>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                KeychainHelper.shared.accessToken = response.accessToken
                KeychainHelper.shared.expiryTime = response.expiresIn
                self.isSuccess.value = true
            case .failure:
                self.isSuccess.value = false
            }
        }
    }
}
