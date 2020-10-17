//
//  FavoritesVCPresenter.swift
//  FortressOfTheMuslim
//
//  Created by Ahmed on 9/15/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import UIKit
protocol FavoritesView: class {
    var presenter: FavoritesVCPresenter? { get set}
    func updatedData()
}

protocol FavoriteCellView: class {
    func displayTitle(text: String)
}
class FavoritesVCPresenter {
    private var prayers: [Prayer] = []
    private weak var view: FavoritesView?
    private var router: FavoritesVCRouter
    private var interactor: FavoritesInteractor
    
    var prayersCount: Int {
        prayers.count
    }
    
    init(view: FavoritesView?, router: FavoritesVCRouter, interactor: FavoritesInteractor) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        self.getPrayers()
    }
    
    func getPrayerTitle(at index: Int) -> String {
        prayers[index].keys.first ?? ""
    }
    
    func getPrayers() {
        let lang = LocalizationManager.shared.getLanguage()!
        interactor.getFavoritePrayers(lang: lang) {[weak self] (prayers) in
            guard let self = self else { return }
            self.prayers = prayers
            self.view?.updatedData()
        }
    }
    
    func configure(cell: FavoriteCellView, at index: Int) {
        let prayerTitle = getPrayerTitle(at: index)
        cell.displayTitle(text: prayerTitle)
    }
    
    func didSelectRowAt(index: Int) {
        let prayer = prayers[index]
        router.navigateToPrayerVC(from: view, prayer: prayer)
    }
    
    func removePrayer(title: String, at index: Int) {
        interactor.deleteFavorite(title: title) {[weak self] in
            guard let self = self else { return }
            self.prayers.remove(at: index)
            self.view?.updatedData()
        }
    }
}
