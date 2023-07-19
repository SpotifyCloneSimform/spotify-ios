//
//  AlbumSong.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 07/07/23.
//

struct AlbumSong: Codable {
    let albumType: String?
    let artists: [AlbumSongArtists]?
    let copyrights: [AlbumCopyRights]?
    let id: String?
    let images: [AlbumImages]?
    let label: String?
    let name: String?
    let releaseDate: String?
    let totalTracks: Int?
    let tracks: AlbumTracks?
}

struct AlbumSongArtists: Codable {
    let id: String?
    let name: String?
}

struct AlbumCopyRights: Codable {
    let text: String?
    let type: String?
}

struct AlbumImages: Codable {
    let height: Int?
    let url: String?
    let width: Int?
}

struct AlbumTracks: Codable {
    let href: String?
    let items: [AlbumItems]?
}

struct AlbumItems: Codable {
    let artists: [AlbumSongArtists]?
    let id: String?
    let name: String?
    let durationMs: Int?
}


