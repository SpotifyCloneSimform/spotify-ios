//
//  LibraryCoordinator.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 06/07/23.
//

import Foundation
import UIKit
class LibraryCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = UserLibraryVC.instantiate(from: .userLibrary)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func gotoViewSongs(songData: LibraryDisplay) {
        let viewPlaylistCoordinator = ViewPlaylistCoordinator(navigationController: navigationController, songData: songData)
        viewPlaylistCoordinator.start()
    }
    
    func  goToArtistProfile(artistId: String) {
        let viewArtistCoodinator = ViewArtistCoordinator(navigationController: navigationController, artistId: artistId)
        viewArtistCoodinator.start()
    }
    
    func goToViewShows(show: LibraryDisplay) {
        let viewPodcastCoordinator = PodcastShowCoordinator(navigationController: navigationController, show: show)
        viewPodcastCoordinator.start()
    }
}
