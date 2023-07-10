//
//  ApiManager+Request.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 04/07/23.
//

import Foundation
import Alamofire

enum RequestItemsType: Equatable {
    case authToken(code: String)
    case refreshToken
    case getUserPlaylists
    case getUserAlbumbs
    case getFeaturedPlaylist
}

// MARK: Extensions
// MARK: EndPointType

extension RequestItemsType: EndPointType {
    
    // MARK: Vars & Lets
    
    var baseURL: String {
        
        switch self {
        case .authToken, .refreshToken:
            return AppConstants.baseAuth
        case .getUserAlbumbs, .getUserPlaylists, .getFeaturedPlaylist:
            return AppConstants.baseApi
        }
    }
    
    var api: String {
        switch self {
        case .authToken, .refreshToken:
            return AppConstants.api
        case .getUserPlaylists, .getUserAlbumbs, .getFeaturedPlaylist:
            return ""
        }
    }
    
    var version: String {
        switch self {
        case .authToken, .refreshToken:
            return ""
        case .getUserAlbumbs, .getUserPlaylists, .getFeaturedPlaylist:
            return AppConstants.apiVersion
        }
    }
    
    var path: String {
        switch self {
        case .authToken, .refreshToken:
            return "token"
        case .getUserPlaylists:
            return "me/playlists"
        case .getUserAlbumbs:
            return "me/top/tracks"
        case .getFeaturedPlaylist:
            return "browse/featured-playlists"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getUserPlaylists, .getUserAlbumbs, .getFeaturedPlaylist:
            return .get
        case .authToken, .refreshToken:
            return .post
        }
    }
    
    var headers: HTTPHeaders? {
        return []
    }
    
    var url: URL {
        return URL(string: self.baseURL + self.api + self.version +  self.path)!
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .authToken, .refreshToken:
            return URLEncoding.httpBody
        case .getUserPlaylists, .getUserAlbumbs, .getFeaturedPlaylist:
            return JSONEncoding.default
        }
    }
    
}
