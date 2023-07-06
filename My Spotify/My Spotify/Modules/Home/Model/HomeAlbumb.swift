//
//  HomeAlbumb.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 05/07/23.
//

import Foundation

// MARK: - HomeAlbumb
struct HomeAlbumb: Codable {
    let items: [ItemAlbumb]?
}

// MARK: - Item
struct ItemAlbumb: Codable {
    let album: Album?
    let artists: [Artist]?
    let availableMarkets: [String]?
    let discNumber, durationMS: Int?
    let explicit: Bool?
    let externalIDS: ExternalIDS?
    let externalUrls: ExternalUrlsAlbumb?
    let href: String?
    let id: String?
    let isLocal: Bool?
    let name: String?
    let popularity: Int?
    let previewURL: String?
    let trackNumber: Int?
    let type, uri: String?

    enum CodingKeys: String, CodingKey {
        case album, artists
        case availableMarkets = "available_markets"
        case discNumber = "disc_number"
        case durationMS = "duration_ms"
        case explicit
        case externalIDS = "external_ids"
        case externalUrls = "external_urls"
        case href, id
        case isLocal = "is_local"
        case name, popularity
        case previewURL = "preview_url"
        case trackNumber = "track_number"
        case type, uri
    }
}

// MARK: - ExternalUrls
struct ExternalUrlsAlbumb: Codable {
    let spotify: String?
}

// MARK: - ImageAlbumb
struct ImageAlbumb: Codable {
    let height: Int?
    let url: String?
    let width: Int?
}
