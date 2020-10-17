//
//  NetworkManager.swift
//  FortressOfTheMuslim
//
//  Created by Ahmed on 9/15/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let cache = NSCache<NSURL, NSData>()
    
    private init() {}
    
    func getAudioData(from url: URL, completion: @escaping(Result<Data, Error>) -> Void) {
        
        if let cachedData = cache.object(forKey: url as NSURL) {
            // use the cached version
            completion(.success(cachedData as Data))
        } else {
            let task = URLSession.shared.dataTask(with: url) { (data, res, error) in
                if let data = data , error == nil {
                    self.cache.setObject(data as NSData, forKey: url as NSURL)
                    completion(.success(data))
                } else {
                    completion(.failure(error!))
                }
                
            }
            task.resume()
        }
    }
}
