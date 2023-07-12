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
    var songs: DisplaySong
    var currentSong: Int
    
    
    init(navigationController: UINavigationController, songs: DisplaySong, currentSong: Int) {
        self.navigationController = navigationController
        self.songs = songs
        self.currentSong = currentSong
    }
    
    func start() {
        let vc = ViewSongVC.instantiate(from: .viewSong)
        vc.coordinator = self
        vc.songs = songs
        vc.currentSong = currentSong
        navigationController.present(vc, animated: true)
    }
}
