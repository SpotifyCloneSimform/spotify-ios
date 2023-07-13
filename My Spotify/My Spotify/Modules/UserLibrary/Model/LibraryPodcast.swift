//
//  LibraryPodcast.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 12/07/23.
//

struct LibraryPodcast: Codable {
    let href: String?
    let items: [PodcastShows]?
}

struct PodcastShows: Codable {
    let addedAt: String?
    let show: Shows?
}

struct Shows: Codable {
    let description: String?
    let id: String?
    let images: [ShowImages]?
    let name: String?
    let publisher: String?
    let totalEpisodes: Int?
}

struct ShowImages: Codable {
    let height: Int?
    let url: String?
    let width: Int?
}
