//
//  SettingsVCPresenter.swift
//  FortressOfTheMuslim
//
//  Created by Ahmed on 9/17/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import UIKit

protocol SettingsView: class {
    var presenter: SettingsVCPresenter? { get set}
}

class SettingsVCPresenter {
    
    private weak var view: SettingsView?
    private var router: SettingsRouter
    
    init(view: SettingsView?, router: SettingsRouter) {
        self.view = view
        self.router = router
    }
    
    func changeLanguage() {
        if LocalizationManager.shared.getLanguage() == .Arabic {
            LocalizationManager.shared.setLanguage(language: .English)
        } else {
            LocalizationManager.shared.setLanguage(language: .Arabic)
        }
    }
}
