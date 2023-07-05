//
//  AuthViewModel.swift
//  My Spotify
//
//  Created by Krunal Patel on 05/07/23.
//

import UIKit

class AuthViewModel {
    
    // MARK: - Lets
    let authCodeSuccess = Dynamic<String>("")
    let errorMessage = Dynamic<String>("")
    let authTokenSuccess = Dynamic<Void>(())
    let isLoading = Dynamic<Bool>(false)
    
    // MARK: - Methods
    func generateAuthCode() {
        guard var authCodeUrl = URL(string: AppConstants.baseAuth + "authorize") else {
            errorMessage.value = "Something want's wrong!"
            return
        }
        
        authCodeUrl.append(queryItems: [
            URLQueryItem(name: "client_id", value: AppConstants.clientId),
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "state", value: AppConstants.state),
            URLQueryItem(name: "scope", value: AppConstants.scopes),
            URLQueryItem(name: "show_dialog", value: "true"),
            URLQueryItem(name: "redirect_uri", value: AppConstants.redirectUri),
        ])
        
        UIApplication.shared.open(authCodeUrl)
    }
    
    func generateAuthToken(with code: String) {
        isLoading.value = true
        let params = [
            "grant_type": "authorization_code",
            "code": code,
            "redirect_uri": AppConstants.redirectUri
        ]
        
        APIManager.shared.call(type: .authToken(code: code), params: params) { [weak self] (result: Result<AuthTokenResponse, CustomError>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                KeychainHelper.shared.accessToken = response.accessToken
                KeychainHelper.shared.refreshToken = response.refreshToken
                KeychainHelper.shared.expiryTime = response.expiresIn
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
            self.isLoading.value = false
        }
    }
}
