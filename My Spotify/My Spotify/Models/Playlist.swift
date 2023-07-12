//
//  Playlist.swift
//  My Spotify
//
//  Created by Krunal Patel on 12/07/23.
//

// MARK: - Playlist
struct Playlist: Codable {
    let collaborative: Bool?
    let description: String?
    let externalUrls: ExternalUrls?
    let followers: Followers?
    let href: String?
    let id: String?
    let images: [Image]?
    let name: String?
    let owner: Owner?
    let primaryColor: String?
    let playlistPublic: Bool?
    let snapshotID: String?
    let tracks: Tracks?
    let type, uri: String?
}

// MARK: - Tracks
struct Tracks: Codable {
    let href: String?
    let items: [Item]?
    let limit: Int?
    let next: String?
    let offset: Int?
    let previous: String?
    let total: Int?
}

// MARK: - Item
struct Item: Codable {
    let addedAt: String?
    let addedBy: Owner?
    let isLocal: Bool?
    let primaryColor: String?
    let track: Track?
    let videoThumbnail: VideoThumbnail?
}

enum TrackType: String, Codable {
    case track = "track"
}
