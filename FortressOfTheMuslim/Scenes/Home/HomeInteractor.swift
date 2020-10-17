//
//  HomeInteractor.swift
//  FortressOfTheMuslim
//
//  Created by Ahmed on 9/14/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import Foundation

class HomeInteractor {
    
    func getAllPrayers(lang: LocalizationManager.Language, completion: @escaping([Prayer]) -> Void) {
        let fileName = "\(lang.rawValue)Prayers.json"
        PersistenceManager.shared.getContent(of: fileName) { (prayers) in
            completion(prayers)
        }
    }
    
    func getFavoritePrayersTitles(completion: @escaping([String]) -> Void) {
        PersistenceManager.shared.getFavoritePrayersTitles { titles in
            completion(titles)
        }
    }
    
    func toggleFavorite(title: String, completion: @escaping() -> Void) {
        PersistenceManager.shared.toggleFavorite(title: title) {
            completion()
        }
    }
}
