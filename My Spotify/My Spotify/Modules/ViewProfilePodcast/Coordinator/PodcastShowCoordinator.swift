//
//  PodcastShowCoordinator.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 12/07/23.
//

import UIKit

class PodcastShowCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    var show: LibraryDisplay
    
    init(navigationController: UINavigationController, show: LibraryDisplay) {
        self.navigationController = navigationController
        self.show = show
    }
    
    func start() {
        let vc = ViewPodcastVC.instantiate(from: .viewPodcastProfile)
        vc.coordinator = self
        vc.show = show
        navigationController.pushViewController(vc, animated: true)
    }
    
}
