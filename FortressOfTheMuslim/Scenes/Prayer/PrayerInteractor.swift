//
//  PrayerInteractor.swift
//  FortressOfTheMuslim
//
//  Created by Ahmed on 9/15/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import Foundation

class PrayerInteractor {
    
    func getAudioData(from url: URL, completion: @escaping(Result<Data, Error>) -> Void) {
        NetworkManager.shared.getAudioData(from: url) { (resul) in
            completion(resul)
        }
    }
}
