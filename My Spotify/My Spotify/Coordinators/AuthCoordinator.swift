//
//  AuthCoordinator.swift
//  My Spotify
//
//  Created by Krunal Patel on 05/07/23.
//

import UIKit

class AuthCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    let code: String?
    
    init(navigationController: UINavigationController, with code: String? = nil) {
        self.navigationController = navigationController
        self.code = code
    }
    
    func start() {
        let authVc = AuthVC.instantiate(from: .auth)
        authVc.authCoordinator = self
        authVc.code = code
        navigationController.viewControllers = [authVc]
    }
}
