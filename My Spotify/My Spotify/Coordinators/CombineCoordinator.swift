//
//  CombineCoordinator.swift
//  My Spotify
//
//  Created by Krunal Patel on 11/07/23.
//

import UIKit

class CombineCoordinator {
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    
    init(navigationController: UINavigationController, with code: String? = nil) {
        self.navigationController = navigationController
        self.tabBarController = UITabBarController()
    }
    
    func start() {
        setupTabBarController()
        navigationController.viewControllers = [tabBarController]
    }
    
    private func setupTabBarController() {
        
        let homeVC = HomeVC.instantiate(from: .home)
        let searchVC = SearchVC.instantiate(from: .search)
        let userLibraryVC = UserLibraryVC.instantiate(from: .userLibrary)
        
        let homeNC = UINavigationController(rootViewController: homeVC)
        let searchNC = UINavigationController(rootViewController: searchVC)
        let userLibraryNC = UINavigationController(rootViewController: userLibraryVC)
        
        homeVC.homeCoordinator = HomeCoordinator(navigationController: homeNC)
        searchVC.searchCoordinator = SearchCoordinator(navigationController: searchNC)
        userLibraryVC.coordinator = LibraryCoordinator(navigationController: userLibraryNC)
        
        homeNC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "HomeOutlined"), selectedImage: UIImage(named: "HomeFilled"))
        searchNC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "SearchOutlined"), selectedImage: UIImage(named: "SearchFilled"))
        userLibraryNC.tabBarItem = UITabBarItem(title: "Library", image: UIImage(named: "LibraryOutlined"), selectedImage: UIImage(named: "LibraryFilled"))
        
        tabBarController.viewControllers = [homeNC, searchNC, userLibraryNC]
    }
}
