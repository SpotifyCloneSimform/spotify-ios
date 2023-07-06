//
//  LibraryPlaylist.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 06/07/23.
//

import Foundation
// MARK: - Welcome
struct LibraryPlaylist: Codable {
    let href: String?
    let items: [LibraryPlaylistItem]?
}

// MARK: - Item
struct LibraryPlaylistItem: Codable {
    let collaborative: Bool?
    let description: String?
    let externalUrls: LibraryPlaylistExternalUrls?
    let href: String?
    let id: String?
    let images: [LibraryImages]?
    let name: String?
    let owner: LibraryOwner?
    let primaryColor: String?
    let itemPublic: Bool?
    let snapshotID: String?
    let tracks: LibraryPlaylistTracks?
    let type, uri: String?
}

// MARK: - ExternalUrls
struct LibraryPlaylistExternalUrls: Codable {
    let spotify: String?
}

// MARK: - Image
struct LibraryImages: Codable {
    let height: Int?
    let url: String?
    let width: Int?
}

// MARK: - Owner
struct LibraryOwner: Codable {
    let displayName: String?
    let externalUrls: LibraryPlaylistExternalUrls?
    let href: String?
    let id, type, uri: String?
}

// MARK: - Tracks
struct LibraryPlaylistTracks: Codable {
    let href: String?
    let total: Int?
}
