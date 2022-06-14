//
//  ListViewController.swift
//  MarvelStudios
//
//  Created by David Manuel Fernández Suárez on 11/6/22.
//  Copyright (c) 2022 MyNSowftware. All rights reserved.
//

import UIKit

protocol ListPresenterLogic: AnyObject {
    func setupView()
    func filterList(text: String?)
    func didSelectRowAt(index: Int)
}

class ListViewController: BaseViewController {
    
    var presenter: ListPresenterLogic?
    var dataStore: ListDataStore?
    var characterList: [List.CharacterViewModel] = []
            
    var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.cellIdentifier)
        return view
    }()
  
    // MARK: Setup
  
    override func setupScene() {        
        let viewController = self
        let presenter = ListPresenter()
        
        presenter.view = viewController
        viewController.dataStore = presenter
        self.presenter = presenter
    }
  
    // MARK: View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.setupView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Buscar ..."
        searchController.searchBar.searchBarStyle = .minimal

        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setupDefaultView() {
        title = "Lista"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}

// MARK: - Display Logic

extension ListViewController: ListDisplayLogic {
   
    func setupView() {
        setupDefaultView()
        setupTableView()
        setupSearchBar()
    }
    
    func updateUI(list: [List.CharacterViewModel]) {
        DispatchQueue.main.async { [weak self] in
            self?.characterList = list
            self?.tableView.reloadData()
        }
    }
}

// MARK: - Delegates

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: ListTableViewCell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.cellIdentifier) as? ListTableViewCell else {
            return UITableViewCell()
        }
        
        let item = characterList[indexPath.row]
        cell.updateUI(item: item)
        return cell
    }
    
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(index: indexPath.row)
    }
    
}


extension ListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        presenter?.filterList(text: text)
    }
    
}


// MARK: - Router Logic

protocol ListRouterLogic: AnyObject {
    func navigateToDetail(id: Int)
}

protocol ListDataPass {
    var dataStore: ListDataStore? { get }
}

extension ListViewController: ListRouterLogic, ListDataPass {
        
    func navigateToDetail(id: Int) {
        coordinator?.navigateToDetail(by: id)
    }
}


