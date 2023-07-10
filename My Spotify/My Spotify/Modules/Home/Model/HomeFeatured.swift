//
//  HomeFeatured.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 05/07/23.
//

import Foundation

// MARK: - HomeFeatured
struct HomeFeatured: Codable {
    let message: String?
    let playlists: PlaylistsFeatured?
}

// MARK: - Playlists
struct PlaylistsFeatured: Codable {
    let href: String?
    let items: [ItemFeatured]?
}

// MARK: - Item
struct ItemFeatured: Codable {
    let collaborative: Bool?
    let description: String?
    let href: String?
    let id: String?
    let images: [ImageFeatured]?
    let name: String?
    let owner: OwnerFeatured?
    let primaryColor, itemPublic: String?
    let snapshotID: String?
    let tracks: TracksFeatured?
    let type, uri: String?

    enum CodingKeys: String, CodingKey {
        case collaborative, description
        case href, id, images, name, owner
        case primaryColor = "primary_color"
        case itemPublic = "public"
        case snapshotID = "snapshot_id"
        case tracks, type, uri
    }
}


// MARK: - Image
struct ImageFeatured: Codable {
    let height: Int?
    let url: String?
    let width: Int?
}

// MARK: - Owner
struct OwnerFeatured: Codable {
    let displayName: String?
    let href: String?
    let id, type, uri: String?

    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case href, id, type, uri
    }
}

// MARK: - Tracks
struct TracksFeatured: Codable {
    let href: String?
    let total: Int?
}
