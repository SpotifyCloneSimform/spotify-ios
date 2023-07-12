//
//  File.swift
//  My Spotify
//
//  Created by Krunal Patel on 04/07/23.
//

import UIKit

enum Storyboard: String {
    case auth = "Auth"
    case home = "Home"
    case userLibrary = "UserLibrary"
    case viewPlaylist = "ViewPlaylist"
    case search = "Search"
    case trackOptions = "TrackOptions"
    case userArtistPorfile = "UserArtistProfile"
    case viewSong = "ViewSong"
}

protocol Storyboarded {
    static func instantiate(from: Storyboard) -> Self
}

extension Storyboarded where Self: UIViewController {
    
    static func instantiate(from storyboard: Storyboard) -> Self {
        // this pulls out "MyApp.MyViewController"
        let fullName = NSStringFromClass(self)

        // this splits by the dot and uses everything after, giving "MyViewController"
        let className = fullName.components(separatedBy: ".")[1]

        // load our storyboard
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: Bundle.main)

        // instantiate a view controller with that identifier, and force cast as the type that was requested
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
