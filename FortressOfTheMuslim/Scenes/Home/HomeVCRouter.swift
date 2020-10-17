//
//  HomeVCRouter.swift
//  FortressOfTheMuslim
//
//  Created by Ahmed on 9/14/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import UIKit

class HomeVCRouter {
    class func createHomeVC() -> UINavigationController {
        let homeVC = HomeVC()
        let interactor = HomeInteractor()
        let router = HomeVCRouter()
        let presenter = HomeVCPresenter(view: homeVC, interactor: interactor, router: router)
        let title = "Home".localized
        homeVC.title = title
        homeVC.presenter = presenter
        homeVC.tabBarItem = UITabBarItem(title: title, image: #imageLiteral(resourceName: "home-un"), selectedImage: #imageLiteral(resourceName: "home"))
        return UINavigationController(rootViewController: homeVC)
    }
    
    func navigateToPrayerVC(from view: HomeView?, prayer: Prayer) {
        let prauerVC = PrayerVCRouter.createPrayerVC(prayer: prayer)
        if let viewController = view as? UIViewController {
            viewController.navigationController?.pushViewController(prauerVC, animated: true)
        }
    }
    
    func presentSearchVC(from view: HomeView?, prayers: [Prayer], action: @escaping (Int) -> Void) {
        let searchVC = SearchRouter.createSearrchVC(prayers: prayers, action: action)
        if let viewController = view as? UIViewController {
            viewController.present(searchVC, animated: true)
        }
    }
}
