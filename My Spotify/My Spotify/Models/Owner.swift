//
//  Owner.swift
//  My Spotify
//
//  Created by Krunal Patel on 12/07/23.
//

// MARK: - Owner
struct Owner: Codable {
    let displayName: String?
    let externalUrls: ExternalUrls?
    let href: String?
    let id: String?
    let type: OwnerType?
    let uri, name: String?

    enum CodingKeys: String, CodingKey {
        case displayName
        case externalUrls
        case href, id, type, uri, name
    }
}

enum OwnerType: String, Codable {
    case artist = "artist"
    case user = "user"
}
