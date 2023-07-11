//
//  UserProfileCoordinator.swift
//  My Spotify
//
//  Created by Krunal Patel on 04/07/23.
//

import UIKit

class UserProfileCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = UserProfileVC.instantiate(from: .userProfile)
        vc.userProfileCoordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToViewSongs(songData: LibraryDisplay) {
        let viewPlaylistCoordinator = ViewPlaylistCoordinator(navigationController: navigationController, songData: songData)
        viewPlaylistCoordinator.start()
    }
    
    func logout() {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.appCoordinator?.goToAuth()
        }
    }
}
