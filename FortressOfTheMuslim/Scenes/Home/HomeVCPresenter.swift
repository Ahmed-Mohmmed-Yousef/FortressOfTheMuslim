//
//  HomeController.swift
//  FortressOfTheMuslim
//
//  Created by Ahmed on 9/10/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import UIKit

protocol HomeView: class {
    var presenter: HomeVCPresenter? { get set }
    func updateData()
    func scrollToIndex(index: Int)
    
}

protocol HomeCellView {
    func displayTitle(text: String)
    func isFavorite(status: Bool)
}

class HomeVCPresenter {
    private var prayers: [Prayer] = []
    private weak var view: HomeView?
    private let interactor: HomeInteractor
    private let router: HomeVCRouter
    
    var prayersCount: Int {
        prayers.count
    }
    
    init(view: HomeView?, interactor: HomeInteractor, router: HomeVCRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        self.getPrayers()
    }
    
    func getPrayerTitle(at index: Int) -> String {
        prayers[index].keys.first ?? ""
    }
    
    func getPrayers() {
        let lang = LocalizationManager.shared.getLanguage()!
        interactor.getAllPrayers(lang: lang) { [unowned self] prayers in
            self.prayers = prayers
            self.view?.updateData()
        }
    }
    
    func configure(cell: HomeCellView, at index: Int) {
        let prayerTitle = getPrayerTitle(at: index)
        interactor.getFavoritePrayersTitles { (titles) in
            let isFavorit =  titles.contains(prayerTitle)
            cell.isFavorite(status: isFavorit)
        }
        cell.displayTitle(text: prayerTitle)
    }
    
    func favoriteToggled(cell: HomeCellView, at index: Int) {
        let prayerTitle = getPrayerTitle(at: index)
        interactor.toggleFavorite(title: prayerTitle) {[unowned self] in
            self.configure(cell: cell, at: index)
        }
    }
    
    func didSelectRowAt(index: Int) {
        let prayer = prayers[index]
        router.navigateToPrayerVC(from: view, prayer: prayer)
    }
    
    func search() {
        router.presentSearchVC(from: view, prayers: prayers) {[unowned self] index in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) { 
                self.view?.scrollToIndex(index: index)
            }
        }
    }
    
}
