//
//  Track.swift
//  My Spotify
//
//  Created by Krunal Patel on 07/07/23.
//

// MARK: - Track
struct Track: Codable {
    let album: Album?
    let artists: [Artist]?
    let discNumber, durationMS: Int?
    let explicit: Bool?
    let externalIDS: ExternalIDS?
    let externalUrls: ExternalUrls?
    let href: String?
    let id: String?
    let isLocal: Bool?
    let name: String?
    let popularity: Int?
    let previewURL: String?
    let trackNumber: Int?
    let type, uri: String?
}
