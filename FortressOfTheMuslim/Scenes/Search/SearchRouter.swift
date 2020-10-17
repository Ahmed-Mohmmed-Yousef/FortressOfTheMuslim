//
//  SearchRouter.swift
//  FortressOfTheMuslim
//
//  Created by Ahmed on 9/19/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import UIKit

class SearchRouter {
    static func createSearrchVC(prayers: [Prayer], action: @escaping (Int) -> () ) -> UINavigationController {
        let searchVC = SearchVC()
        let searchVCPresenter = SearchVCPresenter(view: searchVC, prayers: prayers, action: action)
        searchVC.presenter = searchVCPresenter
        return UINavigationController(rootViewController: searchVC)
    }
}
