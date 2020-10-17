//
//  FavoritesInteractor.swift
//  FortressOfTheMuslim
//
//  Created by Ahmed on 9/15/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import Foundation

class FavoritesInteractor {
    func getFavoritePrayers(lang: LocalizationManager.Language, completion: @escaping([Prayer]) -> Void) {
        getFavoritePrayersTitles { (titles) in
            let fileName = "\(lang.rawValue)Prayers.json"
            PersistenceManager.shared.getContent(of: fileName) { (prayers) in
                let result = prayers.filter{titles.contains($0.keys.first!)}
                completion(result)
            }
        }
    }
    
    func getFavoritePrayersTitles(completion: @escaping([String]) -> Void) {
        PersistenceManager.shared.getFavoritePrayersTitles { titles in
            completion(titles)
        }
    }
    
    func deleteFavorite(title: String, completion: @escaping() -> Void) {
        PersistenceManager.shared.update(prayerTitle: title, actionType: .remove) {
            completion()
        }
    }
}
