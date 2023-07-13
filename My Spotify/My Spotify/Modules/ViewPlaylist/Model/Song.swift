//
//  Song.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 07/07/23.
//

struct Song: Codable {
    let href: String?
    let name: String?
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
    let durationMs: Int?
    let id: String?
    let name: String?
}

struct SongAlbum: Codable {
    let images: [SongAlbumImages]?
    let name: String?
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
