//
//  FavoritesVCRouter.swift
//  FortressOfTheMuslim
//
//  Created by Ahmed on 9/15/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import UIKit

class FavoritesVCRouter {
    
    static func createFavoritesVC() -> UINavigationController {
        let favoritesVC = FavoritesVC()
        let router = FavoritesVCRouter()
        let interactor = FavoritesInteractor()
        let presenter = FavoritesVCPresenter(view: favoritesVC, router: router, interactor: interactor)
        favoritesVC.presenter = presenter
        let title = "Favorites".localized
        favoritesVC.title = title
        favoritesVC.tabBarItem = UITabBarItem(title: title, image: #imageLiteral(resourceName: "favorite-un"), selectedImage: #imageLiteral(resourceName: "favorite"))
        return UINavigationController(rootViewController: favoritesVC)
    }
    
    func navigateToPrayerVC(from view: FavoritesView?, prayer: Prayer) {
        let prauerVC = PrayerVCRouter.createPrayerVC(prayer: prayer)
        if let viewController = view as? UIViewController {
            viewController.navigationController?.pushViewController(prauerVC, animated: true)
        }
    }
}
