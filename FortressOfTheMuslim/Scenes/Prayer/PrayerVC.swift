//
//  PrayerView.swift
//  FortressOfTheMuslim
//
//  Created by Ahmed on 9/12/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import UIKit
import AVFoundation
var audioPlayer: AVAudioPlayer!

class PrayerVC: UIViewController {
        
    var presenter: PrayerVCPresenter?
    var isAudioPlay: Bool = false
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    private var loadingView: UIView!
    
    private var playButton = UIButton(type: .system)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        configurePlayButton()
        configCollectionview()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        self.presenter = nil
        self.stopAudio()
    }
    
    private func configView() {
        view.backgroundColor = Theme.backgroundColor
        title = presenter?.title
        view.tintColor = Theme.tintColor
    }
    
    private func configurePlayButton() {
        view.addSubview(playButton)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        playButton.setImage(#imageLiteral(resourceName: "play-button"), for: .normal)
        playButton.layer.cornerRadius   = 10
        playButton.layer.borderWidth    = 2
        playButton.layer.borderColor    = Theme.tintColor.cgColor
    }
    
    @objc private func playButtonTapped() {
        presenter?.playAudio()
    }
    
    private func configCollectionview() {
        view.addSubview(collectionView)
        collectionView.register(PrayerItemCell.self, forCellWithReuseIdentifier: PrayerItemCell.id)
        collectionView.backgroundColor  = .clear
        collectionView.isPagingEnabled  = true
        collectionView.dataSource       = self
        collectionView.delegate         = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            playButton.widthAnchor.constraint(equalToConstant: 80),
            playButton.heightAnchor.constraint(equalToConstant: 80),
            
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: playButton.topAnchor, constant: -16)
        ])
    }

}

extension PrayerVC: PrayerView {
    
    func lastCellReaction() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    func moveToNextCell(at index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func loadingData() {
        playButton.isEnabled = false
        showLodingView()
    }
    
    func finshLoading() {
        playButton.isEnabled = true
        dismissLoadingView()
    }
    
    func presentAlert(with message: String) {
        let title = "An error occurred".localized
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok".localized, style: .cancel)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }

    func playAudio(with data: Data) {
        audioPlayer = try? AVAudioPlayer(data: data)
        audioPlayer?.play()
        isAudioPlay = true
        playButton.setImage(#imageLiteral(resourceName: "stop"), for: .normal)
    }
    
    func stopAudio() {
        audioPlayer?.stop()
        isAudioPlay = false
        playButton.setImage(#imageLiteral(resourceName: "play-button"), for: .normal)
    }
    
}


extension PrayerVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.prayerItems.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PrayerItemCell.id, for: indexPath) as! PrayerItemCell
        cell.cellIndex = indexPath.row
        cell.delegate = self
        presenter?.configer(cell: cell, at: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PrayerItemCellView
        presenter?.incremntCellCount(index: indexPath.row, cell: cell)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}


extension PrayerVC: PrayerItemCellDelegate {
    func incremntCount(of cell: PrayerItemCellView, at index: Int) {
        presenter?.incremntCellCount(index: index, cell: cell)
    }
}

extension PrayerVC {
    func showLodingView(){
        loadingView = UIView(frame: playButton.bounds)
        playButton.addSubview(loadingView)
        loadingView.layer.cornerRadius = 10
        loadingView.backgroundColor   = .white
        loadingView.alpha             = 0
        UIView.animate(withDuration: 0.25, animations: { self.loadingView.alpha = 0.8 })
        
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.tintColor = Theme.tintColor
        loadingView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView(){
        DispatchQueue.main.async {
            self.loadingView.removeFromSuperview()
            self.loadingView = nil
        }
    }
}
