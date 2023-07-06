//
//  Option.swift
//  My Spotify
//
//  Created by Krunal Patel on 10/07/23.
//

// MARK: - OptionItem
struct OptionItem {
    var iconName: String
    var title: String
    var onClick: (() -> Void)? = nil
}
