//
//  ViewSongsViewModel.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 07/07/23.
//

class ViewSongsViewModel {
    
    // MARK: - Variables
    var success = Dynamic<Song?>(nil)
    var failure = Dynamic<String>("")
    var songs = Dynamic<DisplaySong?>(nil)
    var albumArtist = Dynamic<AlbumArtist?>(nil)
    var delegate: AdditionalInfoAlbum?
    
    // MARK: - Get playlist songs
    func getPlaylistSong(id: String) {
        APIManager.shared.call(type: .getPlaylistSongs(id: id)) { [weak self] (result: Result<Song, CustomError>) in
            guard let self = self else{
                return
            }
            switch result {
            case .success(let songs):
                
                let songsData = songs.tracks?.items?.filter { $0.track?.name?.isEmpty == false }.map { item in
                    let artists = item.track?.artists?.compactMap { $0.name }.joined(separator: ", ")
                    return DisplaySongData(songName: item.track?.name, artistsName: artists, image: item.track?.album?.images?.first?.url, id: item.track?.id, songDuration: item.track?.durationMs, title: "Playing From Playlist", subTitle: songs.name)
                }
                self.songs.value = DisplaySong(type: .playlist, data: songsData)
                
            case .failure(let error):
                self.failure.value = error.body
            }
        }
    }

    // MARK: - Get album songs
    func getAlbumSong(id: String) {
        APIManager.shared.call(type: .getAlbumTracks(id: id)) { [weak self] (result: Result<AlbumSong, CustomError>) in
            guard let self = self else{
                return
            }
            switch result {
            case .success(let albumSongs):
                
                self.delegate?.getAdditionalInfo(footerDetails: DisplayAlbumFooterView(artistId: albumSongs.artists?[0].id ?? "", releaseDate: albumSongs.releaseDate ?? "", totalSongs: albumSongs.totalTracks ?? 0, copyRight: albumSongs.copyrights?.first?.text ?? ""))
                let songData = albumSongs.tracks?.items?.filter { $0.name?.isEmpty == false }.map { item in
                    let artists = item.artists?.compactMap { $0.name }.joined(separator: ", ")
                    return DisplaySongData(songName: item.name, artistsName: artists, image: albumSongs.images?.first?.url, id: item.id, songDuration: item.durationMs ,title: "Playing From Album", subTitle: albumSongs.name)
                }
                self.songs.value = DisplaySong(type: .album, data: songData)
                
            case .failure(let error):
                self.failure.value = error.body
            }
        }
    }
    
    // MARK: - Get followed artists
    func getArtist(id: String) {
        APIManager.shared.call(type: .getArtist(id: id)) { [weak self] (result: Result<AlbumArtist, CustomError>) in
            guard let self = self else{
                return
            }
            switch result {
            case .success(let artist):
                self.albumArtist.value = artist
            case .failure(let error):
                self.failure.value = error.body
            }
        }
    }
}

protocol AdditionalInfoAlbum {
    func getAdditionalInfo(footerDetails: DisplayAlbumFooterView)
}
