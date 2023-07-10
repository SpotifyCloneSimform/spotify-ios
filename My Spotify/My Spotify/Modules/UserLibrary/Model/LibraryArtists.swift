//
//  LibraryArtists.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 06/07/23.
//

import Foundation

// MARK: - LibraryArtists
struct LibraryArtist: Codable {
    let artists: LibraryArtistsData?
}

// MARK: - Artists
struct LibraryArtistsData: Codable {
    let items: [LibraryArtistsItem]?
    let next: String?
    let total: Int?
    let cursors: Cursors?
    let limit: Int?
    let href: String?
}

// MARK: - Cursors
struct Cursors: Codable {
    let after: String?
}

// MARK: - Item
struct LibraryArtistsItem: Codable {
    let followers: LibraryArtistsFollowers?
    let genres: [String]?
    let href: String?
    let id: String?
    let images: [LibraryArtistsImage]?
    let name: String?
    let popularity: Int?
    let type, uri: String?
}


// MARK: - Followers
struct LibraryArtistsFollowers: Codable {
    let href: String?
    let total: Int?
}

// MARK: - Image
struct LibraryArtistsImage: Codable {
    let height: Int?
    let url: String?
    let width: Int?
}
