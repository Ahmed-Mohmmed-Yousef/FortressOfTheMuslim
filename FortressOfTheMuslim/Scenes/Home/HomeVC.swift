//
//  ViewController.swift
//  FortressOfTheMuslim
//
//  Created by Ahmed on 9/9/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    var presenter: HomeVCPresenter?
    
    //MARK:- ui elements
    var tableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewDidLoad()
    }
    
    private func configView() {
        view.backgroundColor = Theme.backgroundColor
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "magnifying-glass"), style: .plain, target: self, action: #selector(searchBarButton))
        configTableView()
    }
    
    @objc private func searchBarButton() {
        presenter?.search()
    }
    
    private func configTableView() {
        view.addSubViews(views: tableView)
        tableView.delegate          = self
        tableView.dataSource        = self
        tableView.backgroundColor   = .clear
        tableView.separatorStyle    = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(HomeCell.self, forCellReuseIdentifier: HomeCell.id)
        
        let safeArea = view.safeAreaLayoutGuide
        tableView.anchor(top: safeArea.topAnchor,
                         leading: safeArea.leadingAnchor,
                         bottom: safeArea.bottomAnchor,
                         trailing: safeArea.trailingAnchor)
    }
    
    
}

extension HomeVC: HomeView {
    func scrollToIndex(index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
//        let cell = tableView.cellForRow(at: indexPath)
//        cell?.backgroundColor = .red
    }
    
    func updateData() {
        self.tableView.reloadData()
    }
    
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.prayersCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.id, for: indexPath) as! HomeCell
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


extension HomeVC: HomeCellDelegate {
    func favoriteToggled(at index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        if let cell = tableView.cellForRow(at: indexPath) as? HomeCell {
            presenter?.favoriteToggled(cell: cell, at: index)
        }
    }
}
