//
//  User.swift
//  My Spotify
//
//  Created by Krunal Patel on 11/07/23.
//

// MARK: - UserProfile
struct UserProfile: Codable {
    let displayName: String?
    let externalUrls: ExternalUrls?
    let href: String?
    let id: String?
    let images: [Image]?
    let type, uri: String?
    let followers: Followers?
    let country, product: String?
    let explicitContent: ExplicitContent?
    let email: String?
    
    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case externalUrls = "external_urls"
        case href, id, images, type, uri, followers, country, product
        case explicitContent = "explicit_content"
        case email
    }
}
