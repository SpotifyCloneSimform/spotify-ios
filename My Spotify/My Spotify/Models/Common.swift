//
//  Common.swift
//  My Spotify
//
//  Created by Krunal Patel on 07/07/23.
//

// MARK: - ExternalUrls
struct ExternalUrls: Codable {
    let spotify: String?
}

// MARK: - Image
struct Image: Codable {
    let height: Int?
    let url: String?
    let width: Int?
}

// MARK: - ExternalIDS
struct ExternalIDS: Codable {
    let isrc: String?
}

// MARK: - Followers
struct Followers: Codable {
    let href: String?
    let total: Int?
}
