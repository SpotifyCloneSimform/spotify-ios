//
//  HomeCoordinator.swift
//  My Spotify
//
//  Created by Krunal Patel on 04/07/23.
//

import UIKit

class HomeCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = HomeVC.instantiate(from: .home)
        vc.homeCoordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
