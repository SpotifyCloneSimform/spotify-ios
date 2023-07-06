//
//  TrackOptionsCoordinator.swift
//  My Spotify
//
//  Created by Krunal Patel on 07/07/23.
//

import UIKit

class TrackOptionsCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    var trackId: String
    
    init(navigationController: UINavigationController, trackId: String) {
        self.navigationController = navigationController
        self.trackId = trackId
    }
    
    func start() {
        let vc = TrackOptionsVC.instantiate(from: .trackOptions)
        vc.trackOptionsCoordinator = self
        navigationController.present(vc, animated: true)
    }
    
    func goToAlbum(trackId: String) {
        // TODO: Navigate to Album screen
    }
}
