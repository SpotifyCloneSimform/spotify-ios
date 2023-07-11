//
//  ViewArtistCoordinator.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 10/07/23.
//

import Foundation
import UIKit

class ViewArtistCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var artistId: String
    
    init(navigationController: UINavigationController, artistId: String) {
        self.navigationController = navigationController
        self.artistId = artistId
    }
    
    func start() {
        let vc = ArtistProfileVC.instantiate(from: .userArtistPorfile)
        vc.coordinator = self
        vc.artistId = artistId
        navigationController.pushViewController(vc, animated: true)
    }
    
    func viewArtist(id: String) {
        let viewArtistCoodinator = ViewArtistCoordinator(navigationController: navigationController, artistId: id)
        viewArtistCoodinator.start()
    }
}
