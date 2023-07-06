//
//  APIManager+Inerceptor.swift
//  My Spotify
//
//  Created by Krunal Patel on 06/07/23.
//

import Alamofire

class APIManagerInterceptor: RequestInterceptor {
    
    // MARK: - Vars & Lets
    private let refreshTokenViewModel = RefreshTokenViewModel()
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        if (request.error?.responseCode == 401) {
            refreshTokenViewModel.isSuccess.bind { isSucsess in
                isSucsess ? completion(.retry) : completion(.doNotRetry)
            }
            refreshTokenViewModel.callRefreshToken()
        } else {
            completion(.doNotRetry)
        }
    }
}
