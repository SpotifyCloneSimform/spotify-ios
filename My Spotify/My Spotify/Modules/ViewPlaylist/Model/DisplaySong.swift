//
//  DisplaySong.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 07/07/23.
//

import Foundation

struct DisplaySong {
    let type: LibraryItemType?
    let data: [DisplaySongData]?
}

struct DisplaySongData {
    let songName: String?
    let artistsName: String?
    let image: String?
    var id: String? = nil
}

struct DisplayAlbumFooterView {
    let artistId: String
    let releaseDate: String
    let totalSongs: Int
    let copyRight: String
}
