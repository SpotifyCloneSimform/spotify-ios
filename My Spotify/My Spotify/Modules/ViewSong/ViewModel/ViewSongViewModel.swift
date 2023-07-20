//
//  ViewSongViewModel.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 11/07/23.
//

class ViewSongViewModel {
    
    // MARK: - Variables
    var isLiked = Dynamic<Bool>(false)
    var errorMessage = Dynamic<String>("")
    var track = Dynamic<Track?>(nil)
    var reloadData = Dynamic<Void>(())
    var songs = Dynamic<DisplaySong?>(nil)
    
    func checkLike(trackId: String) {
        
        let params = [
            "ids": trackId
        ]
        
        APIManager.shared.call(type: .checkLike, params: params) { [weak self](result: Result<[Bool], CustomError>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                self.isLiked.value = response.first ?? false
            case .failure(let error):
                self.errorMessage.value = error.body
                break
            }
        }
    }
    
    func updateLike(trackId: String, isLiked: Bool) {
        let params = [
            "ids": [trackId]
        ]
        
        APIManager.shared.call(type: isLiked ? .likeTrack : .dislikeTrack, params: params) { [weak self] (result: Result<DefaultCodable, CustomError>) in
            
            guard let self = self else {
                return
            }
            
            switch result {
            case .success:
                self.isLiked.value = isLiked
                self.reloadData.fire()
            case .failure(let error):
                if (error.body == APIError.noData) {
                    self.isLiked.value = isLiked
                    self.reloadData.fire()
                } else {
                    self.errorMessage.value = error.body
                }
            }
        }
    }
    
    func getTrack(trackId: String) {
        APIManager.shared.call(type: .getTrack(id: trackId)) { [weak self] (result: Result<Track, CustomError>) in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let track):
                self.track.value = track
            case .failure(let error):
                self.errorMessage.value = error.body
            }
        }
    }
    
    func getAlbumTracks(albumId: String) {
        APIManager.shared.call(type: .getAlbumTracks(id: albumId)) { [weak self] (result: Result<AlbumSong, CustomError>) in
            guard let self = self else{
                return
            }
            switch result {
            case .success(let albumSongs):
                
                let songData = albumSongs.tracks?.items?.filter { $0.name?.isEmpty == false }.map { item in
                    let artists = item.artists?.compactMap { $0.name }.joined(separator: ", ")
                    return DisplaySongData(songName: item.name, artistsName: artists, image: albumSongs.images?.first?.url , id: item.id, songDuration: item.durationMs, title: "Playing From Album", subTitle: albumSongs.name)
                }
                self.songs.value = DisplaySong(type: .album, data: songData)
                
            case .failure(let error):
                self.errorMessage.value = error.body
            }
        }
    }
    
}
