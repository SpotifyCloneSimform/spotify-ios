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
    var primaryColor: String? = nil
    let itemPublic: Bool?
    let snapshotID: String?
    let tracks: Tracks?
    let type, uri: String?
}

// MARK: - Owner
struct Owner: Codable {
    let displayName: String?
    let externalUrls: ExternalUrls?
    let href: String?
    let id, type, uri: String?
}

// MARK: - Tracks
struct Tracks: Codable {
    let href: String?
    let total: Int?
}
