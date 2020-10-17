//
//  SearchVC.swift
//  FortressOfTheMuslim
//
//  Created by Ahmed on 9/19/20.
//  Copyright © 2020 Ahmed,ORG. All rights reserved.
//

import UIKit

class SearchVC: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    var presenter: SearchVCPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done".localized, style: .done, target: self, action: #selector(dismissView))
        configSearchController()
    }
    
    private func configSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search".localized
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      if isFiltering {
        return presenter?.prayersCount ?? 0
      }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = presenter?.filteredPrayerTitle(at: indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(index: indexPath.row)
    }
}

extension SearchVC: SearchView, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        presenter?.filterContentForSearchText(searchBar.text!)
    }
    
    
    func updateData() {
        tableView.reloadData()
    }
    
    @objc func dismissView() {
        self.searchController.dismiss(animated: true)
        self.dismiss(animated: true, completion: nil)
    }

}
