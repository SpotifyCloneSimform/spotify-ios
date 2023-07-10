//
//  LibraryAlbum.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 06/07/23.
//

import Foundation
struct LibraryAlbum: Codable {
    let href: String?
    let items: [LibraryAlbumItem]?
}

struct LibraryAlbumItem: Codable {
    let addedAt: String?
    let album: LibraryAlbumData
}

struct LibraryAlbumImages: Codable {
    let height: Int?
    let url: String?
    let width: Int?
}

struct LibraryAlbumData: Codable {
    let artists: [LibraryAlbumArtists]?
    let id: String?
    let images: [LibraryAlbumImages]?
    let label: String?
    let name: String?

}

struct LibraryAlbumArtists: Codable {
    let name: String?
}
