//
//  PrayerController.swift
//  FortressOfTheMuslim
//
//  Created by Ahmed on 9/12/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import Foundation

protocol PrayerView: class {
    var isAudioPlay: Bool { get set }
    var presenter: PrayerVCPresenter? { get set }
    func playAudio(with data: Data)
    func stopAudio()
    func loadingData()
    func finshLoading()
    func presentAlert(with message: String)
    func moveToNextCell(at index: Int)
    func lastCellReaction()
}

protocol PrayerItemCellView {
    var count: Int { get set }
    func displayText(text: String?)
    func numberOfRepetion(number: Int)
    func incrementCount(with value: Int)
}

class PrayerVCPresenter {
    
    private let dispatchGroup = DispatchGroup()
    private weak var view: PrayerView?
    private var prayer: Prayer
    private let interactor: PrayerInteractor
    
    private var arrData = [Data]()
    
    init(view: PrayerView?, interactor: PrayerInteractor, prayer: Prayer) {
        self.view = view
        self.interactor = interactor
        self.prayer = prayer
    }
    var title: String? {
        prayer.keys.first
    }
    
    var prayerItems: [PrayerItem] {
        prayer.values.first!
    }
    
    func playAudio() {
        if !view!.isAudioPlay {
            view?.loadingData()
            let url = prayerItems[0].audio
            interactor.getAudioData(from: URL(string: url)!) {[weak self] (result) in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.view?.finshLoading()
                    switch result {
                    case .success(let data):
                        self.view?.playAudio(with: data)
                    case .failure(let error):
                        self.view?.presentAlert(with: error.localizedDescription)
                    }
                }
            }
        } else {
            view?.stopAudio()
        }
        
    }
    
    
    func configer(cell: PrayerItemCellView, at index: Int) {
        let prayerItem = prayerItems[index]
        let text = LocalizationManager.shared.getLanguage()!.rawValue == "ar" ?
            prayerItem.arabicText : prayerItem.translatedText
        
        cell.displayText(text: text)
        cell.numberOfRepetion(number: prayerItem.contentREPEAT)
    }
    
    func incremntCellCount(index: Int, cell: PrayerItemCellView) {
        let prayerItem = prayerItems[index]
        if prayerItem.contentREPEAT > cell.count {
            cell.incrementCount(with: cell.count + 1)
            if cell.count == prayerItem.contentREPEAT {
                if prayerItem == prayerItems.last {
                    view?.lastCellReaction()
                } else {
                    view?.moveToNextCell(at: index + 1)
                }
            }
        }
        
    }
}

extension PrayerVCPresenter {
    
}
