//
//  DisplaySong.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 07/07/23.
//

struct DisplaySong {
    var type: LibraryItemType?
    var data: [DisplaySongData]?
}
struct DisplaySongData {
    let songName: String?
    let artistsName: String?
    let image: String?
    var id: String? = nil
    var songDuration: Int? = nil
    var title: String? = nil
    var subTitle: String? = nil
}

struct DisplayAlbumFooterView {
    let artistId: String
    let releaseDate: String
    let totalSongs: Int
    let copyRight: String
}
