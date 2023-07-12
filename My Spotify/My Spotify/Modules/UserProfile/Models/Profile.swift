//
//  Profile.swift
//  My Spotify
//
//  Created by Krunal Patel on 12/07/23.
//

struct ProfileDisplayItem {
    let title: String
    let items: [ProfileItem]
}

class ProfileItem {
    let id: String?
    let image: String?
    let name: String?
    let ownerName: String?
    var followers: Int
    var artists: [String]?
    
    init(id: String?, image: String?, name: String?, ownerName: String?, followers: Int = 0, artists: [String]? = nil) {
        self.id = id
        self.image = image
        self.name = name
        self.ownerName = ownerName
        self.followers = followers
        self.artists = artists
    }
}
