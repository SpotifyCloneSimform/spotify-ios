//
//  SearchCoordinator.swift
//  My Spotify
//
//  Created by Krunal Patel on 06/07/23.
//

import UIKit

class SearchCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = SearchVC.instantiate(from: .search)
        vc.searchCoordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToSearchScreen() {
        let vc = SearchHistoryVC.instantiate(from: .search)
        vc.searchCoordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
