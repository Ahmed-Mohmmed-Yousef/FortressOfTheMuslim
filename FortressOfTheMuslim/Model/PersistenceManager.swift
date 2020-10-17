//
//  Helper.swift
//  FortressOfTheMuslim
//
//  Created by Ahmed on 9/10/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import Foundation

enum PersistanceActionType {
    case add, remove
}

class PersistenceManager {
    static var shared = PersistenceManager()
    let defults = UserDefaults.standard
    private let favoriteTitlesKey = "favoriteTitlesKey"
    
    func getAllPrayers() -> [Prayer] {
        let lang = LocalizationManager.shared.getLanguage()
        if let lang = lang{
            let content = Bundle.main.decode(Content.self, from: "\(lang.rawValue)Prayers.json")
            return content.content
        }
        return []
    }
    
    func getContent(of fileName: String, completion: @escaping([Prayer]) -> Void) {
        let content = Bundle.main.decode(Content.self, from: fileName)
        completion(content.content)
    }
    
    func getFavoritePrayersTitles(completion: ([String]) -> Void){
        guard let data = defults.object(forKey: favoriteTitlesKey) as? Data else {
            completion([])
            return
        }
        let decoder = JSONDecoder()
        guard let indices = try? decoder.decode([String].self, from: data) else {
            completion([])
            return
        }
        completion(indices)
    }
    
    func update(prayerTitle: String, actionType: PersistanceActionType, completion: @escaping() -> Void) {
        getFavoritePrayersTitles { titles in
            var prayersTitles = titles
            switch actionType {
                
            case .add:
                guard !titles.contains(prayerTitle) else {
                    completion()
                    return
                }
                prayersTitles.append(prayerTitle)
            case .remove:
                let index = prayersTitles.firstIndex(of: prayerTitle)!
                prayersTitles.remove(at: index)
            }
            save(prayersTitles: prayersTitles)
            completion()
        }
    }
    
    func toggleFavorite(title: String, completion: @escaping() -> Void) {
        getFavoritePrayersTitles { titles in
            let persistanceActionType: PersistanceActionType = titles.contains(title) ? .remove : .add
            update(prayerTitle: title, actionType: persistanceActionType) {
                completion()
            }
        }
    }
    
    
    func save(prayersTitles: [String]) {
        let encoder = JSONEncoder()
        let encoderFavorites = try? encoder.encode(prayersTitles)
        defults.set(encoderFavorites, forKey: favoriteTitlesKey)
        defults.synchronize()
    }
    
}
