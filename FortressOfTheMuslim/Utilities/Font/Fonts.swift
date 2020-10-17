//
//  Fonts.swift
//  FortressOfTheMuslim
//
//  Created by Ahmed on 9/15/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import UIKit

class Fonts {
    static let arabicFont     = "Tajawal-Regular"
    static let englishFont    = "Ubuntu-Regular"
    
    
    static func languageFont(with size: CGFloat) -> UIFont? {
        guard let lang = LocalizationManager.shared.getLanguage(), lang == .Arabic else {
            return UIFont(name: englishFont, size: size)
        }
        return UIFont(name: arabicFont, size: size)
    }
}
