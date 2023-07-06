//
//  HomePlaylist.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 05/07/23.
//

import Foundation

// MARK: - Welcome
struct HomePlaylist: Codable {
    let href: String?
    let items: [Item]?
}

// MARK: - Item
struct Item: Codable {
    let collaborative: Bool?
    let description: String?
    let href: String?
    let id: String?
    let images: [Image]?
    let name: String?
    let owner: Owner?
    let primaryColor: String? = nil
    let itemPublic: Bool?
    let snapshotID: String?
    let tracks: Tracks?
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

// MARK: - Owner
struct Owner: Codable {
    let displayName: String?
    let externalUrls: ExternalUrls?
    let href: String?
    let id, type, uri: String?

    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case externalUrls = "external_urls"
        case href, id, type, uri
    }
}

// MARK: - Tracks
struct Tracks: Codable {
    let href: String?
    let total: Int?
}
