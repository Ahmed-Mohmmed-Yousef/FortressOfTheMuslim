//
//  FavoritesVC.swift
//  FortressOfTheMuslim
//
//  Created by Ahmed on 9/15/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController {
    
    var presenter: FavoritesVCPresenter?
    var tableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        configTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewDidLoad()
    }
    
    private func configView() {
        view.backgroundColor = Theme.backgroundColor
    }
    
    private func configTableView() {
        view.addSubview(tableView)
        tableView.delegate          = self
        tableView.dataSource        = self
        tableView.backgroundColor   = .clear
        tableView.separatorStyle    = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.id)
        
        let safeArea = view.safeAreaLayoutGuide
        tableView.anchor(top: safeArea.topAnchor,
                         leading: safeArea.leadingAnchor,
                         bottom: safeArea.bottomAnchor,
                         trailing: safeArea.trailingAnchor)
    }
    
    
}

extension FavoritesVC: FavoritesView {
    func updatedData() {
        self.tableView.reloadData()
    }
}

extension FavoritesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.prayersCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.id, for: indexPath) as! FavoriteCell
        cell.delegate = self
        cell.cellIndex = indexPath.row
        presenter?.configure(cell: cell, at: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}


extension FavoritesVC: FavoriteCellDelegate {
    func removeFavorite(prayerTitel: String, at index: Int) {
        presenter?.removePrayer(title: prayerTitel, at: index)
    }
}
