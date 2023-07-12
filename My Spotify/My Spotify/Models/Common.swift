//
//  Common.swift
//  My Spotify
//
//  Created by Krunal Patel on 07/07/23.
//

enum ReleaseDatePrecision: String, Codable {
    case day = "day"
    case year = "year"
}

// MARK: - DataItems
struct DataItems<T: Codable>: Codable {
    let href: String?
    let items: [T]?
    let limit: Int?
    let next: String?
    let offset: Int?
    let previous: String?
    let total: Int?
}

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

// MARK: - ExplicitContent
struct ExplicitContent: Codable {
    let filterEnabled: Bool?
    let filterLocked: Bool?
    
    enum CodingKeys: String, CodingKey {
        case filterEnabled = "filter_enabled"
        case filterLocked = "filter_locked"
    }
}

// MARK: - VideoThumbnail
struct VideoThumbnail: Codable {
    let url: String?
}

// MARK: - DefaultCodable
// Default structure used when there is no response body.
struct DefaultCodable: Codable {
    
}
