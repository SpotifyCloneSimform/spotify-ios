//
//  Search.swift
//  My Spotify
//
//  Created by Krunal Patel on 06/07/23.
//

// MARK: - SearchResponse
struct SearchResponse: Codable {
    let albums: SearchData<Album>?
    let tracks: SearchData<Track>?
}

// MARK: - SearchData
struct SearchData<T: Codable>: Codable {
    let href: String?
    let items: [T]?
    let limit: Int?
    let next: String?
    let offset: Int?
    let previous: String?
    let total: Int?
}

struct SearchItem {
    var id: String
    var image: String
    var name: String
    var description: String
    var type: ItemType
}

enum ItemType: String, CaseIterable {
    case album = "album"
    case artist = "artist"
    case playlist = "playlist"
    case track = "track"
    case show = "show"
    case episode = "episode"
    case audiobook = "audiobook"
}
