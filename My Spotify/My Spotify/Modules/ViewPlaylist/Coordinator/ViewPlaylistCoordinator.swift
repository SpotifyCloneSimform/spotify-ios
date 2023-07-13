//
//  ViewPlaylistCoordinator.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 07/07/23.
//

import UIKit

class ViewPlaylistCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var songData: LibraryDisplay
    var songs: DisplaySong = DisplaySong(type: nil, data: [])
    
    init(navigationController: UINavigationController, songData: LibraryDisplay) {
        self.navigationController = navigationController
        self.songData = songData
    }
    
    func start() {
        let vc = ViewPlaylistVC.instantiate(from: .viewPlaylist)
        vc.coordinator = self
        vc.songData = self.songData
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToViewSong(currentSong: Int) {
        let viewSongCoordinator = ViewSongCoordinator(navigationController: navigationController, songs: songs, currentSong: currentSong)
        viewSongCoordinator.start()
    }
}
