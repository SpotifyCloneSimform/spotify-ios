//
//  LibraryDisplay.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 06/07/23.
//

struct LibraryDisplayData {
    let index: Int
    let isFiltered: Bool
    let type: LibraryItemType
    let data: [LibraryDisplay]
}

struct LibraryDisplay {
    let name: String?
    let ownerDisplayName: String?
    let image: String?
    let type: LibraryItemType
    let id: String?
    var description: String = ""
}

enum LibraryItemType: String {
    case all
    case album
    case artists
    case playlist
    case podcast
}

extension LibraryItemType {
    var index: Int {
        switch self {
        case .playlist:
            return 0
        case .album:
            return 1
        case .artists:
            return 2
        case .podcast:
            return 3
        case .all:
            return 5
        }
    }
}
