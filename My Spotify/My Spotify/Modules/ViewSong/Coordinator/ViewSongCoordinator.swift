//
//  ViewSongCoordinator.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 11/07/23.
//

import UIKit

class ViewSongCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var songs: DisplaySong = DisplaySong(type: nil, data: [])
    var currentSong: Int = 0
    var trackId: String? = nil
    
    init(navigationController: UINavigationController, songs: DisplaySong, currentSong: Int) {
        self.navigationController = navigationController
        self.songs = songs
        self.currentSong = currentSong
    }
    
    init(navigationController: UINavigationController, trackId: String) {
        self.navigationController = navigationController
        self.trackId = trackId
    }
    
    func start() {
        let vc = ViewSongVC.instantiate(from: .viewSong)
        vc.coordinator = self
        vc.songs = songs
        vc.trackId = trackId
        vc.currentSong = currentSong
        navigationController.present(vc, animated: true)
    }
}
