//
//  HomePlaylist.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 05/07/23.
//

import Foundation

// MARK: - Welcome
struct HomePlaylist: Codable {
    let href: String?
    let items: [Playlist]?
}
