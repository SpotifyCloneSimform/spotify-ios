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
    case getUserArtists
    case getAlbums
    case getPlaylistSongs(id: String)
    case getAlbumTracks(id: String)
    case getArtist(id: String)
    case categories
    case search
    case track(id: String)
    case checkLike
    case likeTrack
    case dislikeTrack
}

// MARK: Extensions
// MARK: EndPointType

extension RequestItemsType: EndPointType {
    
    // MARK: Vars & Lets
    
    var baseURL: String {
        
        switch self {
        case .authToken, .refreshToken:
            return AppConstants.baseAuth
        case .getUserPlaylists, .getUserArtists, .getAlbums, .getPlaylistSongs, .getAlbumTracks, .getArtist, .getUserAlbumbs, .getFeaturedPlaylist, .categories, .search, .track, .checkLike, .likeTrack, .dislikeTrack:
            return AppConstants.baseApi
        }
    }
    
    var api: String {
        switch self {
        case .authToken, .refreshToken:
            return AppConstants.api
        case .getUserPlaylists, .getUserArtists, .getAlbums, .getPlaylistSongs, .getAlbumTracks, .getArtist, .getUserAlbumbs, .getFeaturedPlaylist, .categories, .search, .track, .checkLike, .likeTrack, .dislikeTrack:
            return ""
        }
    }
    
    var version: String {
        switch self {
        case .authToken, .refreshToken:
            return ""
        case .getUserPlaylists, .getUserArtists, .getAlbums, .getPlaylistSongs, .getAlbumTracks, .getArtist, .getUserAlbumbs, .getFeaturedPlaylist, .categories, .search, .track, .checkLike, .likeTrack, .dislikeTrack:
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
        case .getUserArtists:
            return "me/following?type=artist"
        case .getAlbums:
            return "me/albums"
        case .getPlaylistSongs(let id):
            return "playlists/\(id)"
        case .getAlbumTracks(let id):
            return "albums/\(id)"
        case .getArtist(let id):
            return "artists/\(id)"
        case .categories:
            return "browse/categories"
        case .search:
            return "search"
        case .track(let id):
            return "tracks/\(id)"
        case .checkLike:
            return "me/tracks/contains"
        case .likeTrack, .dislikeTrack:
            return "me/tracks"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getUserPlaylists, .getUserArtists, .getAlbums, .getPlaylistSongs, .getAlbumTracks, .getArtist, .getUserAlbumbs, .getFeaturedPlaylist, .categories, .search, .track, .checkLike:
            return .get
        case .authToken, .refreshToken:
            return .post
        case .likeTrack:
            return .put
        case .dislikeTrack:
            return .delete
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
        case .search, .checkLike:
            return URLEncoding.queryString
        default:
            return JSONEncoding.default
        }
    }
    
}
