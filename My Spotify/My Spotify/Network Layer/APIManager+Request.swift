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
    case authenticatedUserProfile
    case getUserPlaylists
    case getUserAlbumbs
    case getFeaturedPlaylist
    case getUserArtists
    case getAlbums
    case playlist(id: String)
    case getPlaylistSongs(id: String)
    case getAlbumTracks(id: String)
    case getArtist(id: String)
    case categories
    case search
    case track(id: String)
    case checkLike
    case likeTrack
    case dislikeTrack
    case getArtistTopTracks(id: String)
    case getRelatedArtists(id: String)
    case getUserPodcats
    case getShows(id: String)
    case categoryPlaylist(category: String)
}

// MARK: Extensions
// MARK: EndPointType

extension RequestItemsType: EndPointType {
    
    // MARK: Vars & Lets
    
    var baseURL: String {
        
        switch self {
        case .authToken, .refreshToken:
            return AppConstants.baseAuth
        case .authenticatedUserProfile, .getUserPlaylists, .getUserArtists, .getAlbums, .playlist, .getPlaylistSongs, .getAlbumTracks, .getArtist, .getUserAlbumbs, .getFeaturedPlaylist, .categories, .search, .track, .checkLike, .likeTrack, .dislikeTrack, .getArtistTopTracks, .getRelatedArtists, .getUserPodcats, .getShows, .categoryPlaylist:
            return AppConstants.baseApi
        }
    }
    
    var api: String {
        switch self {
        case .authToken, .refreshToken:
            return AppConstants.api
        case .authenticatedUserProfile, .getUserPlaylists, .getUserArtists, .getAlbums, .playlist, .getPlaylistSongs, .getAlbumTracks, .getArtist, .getUserAlbumbs, .getFeaturedPlaylist, .categories, .search, .track, .checkLike, .likeTrack, .dislikeTrack, .getArtistTopTracks, .getRelatedArtists, .getUserPodcats, .getShows, .categoryPlaylist:
            return ""
        }
    }
    
    var version: String {
        switch self {
        case .authToken, .refreshToken:
            return ""
        case .authenticatedUserProfile, .getUserPlaylists, .getUserArtists, .getAlbums, .playlist, .getPlaylistSongs, .getAlbumTracks, .getArtist, .getUserAlbumbs, .getFeaturedPlaylist, .categories, .search, .track, .checkLike, .likeTrack, .dislikeTrack, .getArtistTopTracks, .getRelatedArtists, .getUserPodcats, .getShows, .categoryPlaylist:
            return AppConstants.apiVersion
        }
    }
    
    var path: String {
        switch self {
        case .authToken, .refreshToken:
            return "token"
        case .authenticatedUserProfile:
            return "me"
        case .getUserPlaylists:
            return "me/playlists?limit=50"
        case .getUserAlbumbs:
            return "me/top/tracks"
        case .getFeaturedPlaylist:
            return "browse/featured-playlists"
        case .getUserArtists:
            return "me/following?type=artist"
        case .getAlbums:
            return "me/albums"
        case .playlist(let id):
            return "playlists/\(id)"
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
        case .getArtistTopTracks(let id):
            return "artists/\(id)/top-tracks?market=IN"
        case .getRelatedArtists(let id):
            return "artists/\(id)/related-artists"
        case .getUserPodcats:
            return "me/shows"
        case .getShows(let id):
            return "shows/\(id)/episodes"
        case .categoryPlaylist(let category):
            return "browse/categories/\(category)/playlists"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .authenticatedUserProfile, .getUserPlaylists, .getUserArtists, .getAlbums, .playlist, .getPlaylistSongs, .getAlbumTracks, .getArtist, .getUserAlbumbs, .getFeaturedPlaylist, .categories, .search, .track, .checkLike, .getRelatedArtists, .getArtistTopTracks, .getUserPodcats, .getShows, .categoryPlaylist:
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

