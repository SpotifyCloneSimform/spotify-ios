//
//  PodcastShowDetail.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 12/07/23.
//

struct PodcastShowDetail: Codable {
    let href: String?
    let items: [PodcastShowsItems]?
}

struct PodcastShowsItems: Codable {
    let description: String?
    let durationMs: Int?
    let id: String?
    let images: [ShowImages]?
    let name: String?
    let releaseDate: String?
}
