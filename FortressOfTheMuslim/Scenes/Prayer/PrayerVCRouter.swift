//
//  PrayerVCRouter.swift
//  FortressOfTheMuslim
//
//  Created by Ahmed on 9/14/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import UIKit

class PrayerVCRouter {
    
    class func createPrayerVC(prayer: Prayer) -> UIViewController {
        let prayerVC = PrayerVC()
        let interactor = PrayerInteractor()
        let presenter = PrayerVCPresenter(view: prayerVC, interactor: interactor, prayer: prayer)
        prayerVC.presenter = presenter
        return prayerVC
    }
}
