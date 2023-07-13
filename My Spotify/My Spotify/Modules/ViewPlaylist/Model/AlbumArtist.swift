//
//  AlbumArtist.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 07/07/23.
//

struct AlbumArtist: Codable {
    let followers: ArtistFollowers?
    let images: [AlbumArtistImage]?
    let name: String?   
}

struct ArtistFollowers: Codable {
    let href: String?
    let total: Int?
}

struct AlbumArtistImage: Codable {
    let height: Int?
    let url: String?
    let width: Int?
}
