//
//  Song.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 07/07/23.
//

import Foundation

struct Song: Codable {
    let href: String?
    let tracks: Songs?
}

struct Songs: Codable {
    let href: String?
    let items: [TrackItems]?
}

struct TrackItems: Codable {
    let added_at: String?
    let track: TrackData?
}

struct TrackData: Codable {
    let album: SongAlbum?
    let artists: [SongArtists]?
    let id: String?
    let name: String?
}

struct SongAlbum: Codable {
    let images: [SongAlbumImages]?
}

struct SongAlbumImages: Codable {
    let height: Int?
    let url: String?
    let width: Int?
}

struct SongArtists: Codable {
    let id: String?
    let name: String?
}
