//
//  SearchVCPresenter.swift
//  FortressOfTheMuslim
//
//  Created by Ahmed on 9/19/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import Foundation

protocol SearchView: class {
    var presenter: SearchVCPresenter? { get set }
    func updateData()
    func dismissView()
}

class SearchVCPresenter {
    private var prayers: [Prayer]
    private weak var view: SearchView?
    var filteredPrayer: [Prayer] = []
    var action: (Int) -> ()
    
    var prayersCount: Int {
        filteredPrayer.count
    }
    init(view: SearchView?, prayers: [Prayer], action: @escaping (Int) -> ()) {
        self.view = view
        self.prayers = prayers
        self.action = action
    }
    
    func getPrayerTitle(prayer: Prayer) -> String {
        prayer.keys.first ?? ""
    }
    
    func filteredPrayerTitle(at index: Int) -> String {
        filteredPrayer[index].keys.first ?? ""
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredPrayer = prayers.filter({ (prayer) -> Bool in
            getPrayerTitle(prayer: prayer).contains(searchText)
        })
        
        view?.updateData()
    }
    
    func didSelectRowAt(index: Int){
        let title = filteredPrayerTitle(at: index)
        let prayerIndex = prayers.firstIndex { getPrayerTitle(prayer: $0) == title} ?? 0
        view?.dismissView()
        action(prayerIndex)
    }
}
