//
//  Artist.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 10/07/23.
//

struct ArtistProfile: Codable {
    let followers: ArtistProfileFollowers?
    let gernes: [String]?
    let id: String?
    let images: [Image]?
    let name: String?
}

struct ArtistProfileFollowers: Codable {
    let href: String?
    let total: Int?
}

struct ArtistTopTracks: Codable {
    let tracks: [ArtistTopTracksData]?
}

struct ArtistTopTracksData: Codable {
    let album: AlbumSong?
    let artist: [SongArtists]?
    let durationMs: Int?
    let id: String?
    let name: String?
}

struct RelatedArtists: Codable {
    let artists: [AlbumSong]?
}
