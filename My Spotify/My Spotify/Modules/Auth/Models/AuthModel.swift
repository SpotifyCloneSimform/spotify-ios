//
//  AuthModel.swift
//  My Spotify
//
//  Created by Krunal Patel on 05/07/23.
//

struct AuthTokenResponse: Codable {
    
    let accessToken: String?
    let token_type: String?
    let expiresIn: Int?
    let refreshToken: String?
    let scope: String?
}
