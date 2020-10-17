//
//  MainTabBarController.swift
//  FortressOfTheMuslim
//
//  Created by Ahmed on 9/12/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        
    }
    
    
    private func createFavoritesView() -> UINavigationController {
        let favoritesVC = FavoritesViewQ()
        let title = "Favorites".localized
        favoritesVC.title = title
        favoritesVC.tabBarItem = UITabBarItem(title: title, image: #imageLiteral(resourceName: "favorite-un"), selectedImage: #imageLiteral(resourceName: "favorite"))
        return UINavigationController(rootViewController: favoritesVC)
    }
    
    private func createSettingsView() -> UINavigationController {
        let settingsView = SettingsViewQ()
        let title = "Settings".localized
        settingsView.title = title
        settingsView.tabBarItem = UITabBarItem(title: title, image: #imageLiteral(resourceName: "settings-un"), selectedImage: #imageLiteral(resourceName: "settings"))
        return UINavigationController(rootViewController: settingsView)
    }
    
    private func setupTabBar() {
        UINavigationBar.appearance().tintColor = Theme.tintColor
        tabBar.tintColor = Theme.tintColor
        viewControllers = [HomeVCRouter.createHomeVC(),
                           FavoritesVCRouter.createFavoritesVC(),
                           SettingsRouter.createSettingsVC()]
    }
    

}
