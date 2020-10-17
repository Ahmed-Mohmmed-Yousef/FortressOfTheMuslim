//
//  SettingsRouter.swift
//  FortressOfTheMuslim
//
//  Created by Ahmed on 9/17/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import UIKit

class SettingsRouter {
    static func createSettingsVC() -> UINavigationController {
        let settingsVC = SettingsVC()
        let router = SettingsRouter()
        let presenter = SettingsVCPresenter(view: settingsVC, router: router)
        settingsVC.presenter = presenter
        let title = "Settings".localized
        settingsVC.title = title
        settingsVC.tabBarItem = UITabBarItem(title: title, image: #imageLiteral(resourceName: "settings-un"), selectedImage: #imageLiteral(resourceName: "settings"))
        return UINavigationController(rootViewController: settingsVC)
    }
}
