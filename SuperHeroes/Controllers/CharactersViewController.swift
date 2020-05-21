//
//  CharactersViewController.swift
//  SuperHeroes
//
//  Created by Joseph Umoru on 14/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import UIKit

class CharactersViewController: UIViewController, ShowAlert {
    private enum CellIdentifiers {
      static let list = "characterTableViewCell"
    }
    
    @IBOutlet weak var charactersTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var viewModel: CharactersViewModel!
    var tableViewDataSource: CharactersViewControllerDataSource?
    var tableViewDelegate: CharactersViewControllerTableViewDelegate?
    var tableViewPrefetchDataSource: CharactersViewControllerPrefetchDataSource?
    var tableViewSearchResultsUpdating: CharacterViewControllerSearchResultsUpdating?
    private var shouldShowLoadingCell = false
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.color = WallapopTheme.colorChoice
        activityIndicator.startAnimating()
        charactersTableView.isHidden = true
        charactersTableView.separatorColor = WallapopTheme.colorChoice
        let endpoint = Endpoint.getRequest()
        viewModel = CharactersViewModel(endPoint: endpoint, delegate: self)
        viewModel.fetchCharacters()
        tableViewDataSource = CharactersViewControllerDataSource(viewModel: viewModel, reusableIdentifier: CellIdentifiers.list)
        tableViewDelegate = CharactersViewControllerTableViewDelegate()
        tableViewPrefetchDataSource = CharactersViewControllerPrefetchDataSource(viewModel: viewModel)
        tableViewSearchResultsUpdating = CharacterViewControllerSearchResultsUpdating(viewModel: viewModel, delegate: self)
        charactersTableView.delegate = tableViewDelegate
        charactersTableView.dataSource = tableViewDataSource
        charactersTableView.prefetchDataSource = tableViewPrefetchDataSource
        searchController.searchResultsUpdater = tableViewSearchResultsUpdating
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    @IBSegueAction func showCharacterDescriptionViewController(coder: NSCoder) -> CharacterDescriptionViewController? {
        
        guard let selectedRow = charactersTableView.indexPathForSelectedRow?.row else {
          return nil
        }
        let singleResult = viewModel.character(at: selectedRow)
        let characterDescriptionViewModel = CharacterDescriptionViewControllerViewModel(result: singleResult)
        return CharacterDescriptionViewController(viewModel: characterDescriptionViewModel, coder: coder)

    }

}

extension CharactersViewController: CharactersViewModelDelegate {
    func onReloadTableViewData() {
        charactersTableView.reloadData()
    }
    
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        guard let newIndexPathsToReload = newIndexPathsToReload else {
            activityIndicator.stopAnimating()
            charactersTableView.isHidden = false
            charactersTableView.reloadData()
            return
        }
        
        let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
        charactersTableView.reloadRows(at: indexPathsToReload, with: .automatic)
    }
    
    func onFetchFailed(with reason: String) {
      activityIndicator.stopAnimating()
      
      let title = "Warning"
      let action = UIAlertAction(title: "OK", style: .default)
      showAlertView(with: title , message: reason, actions: [action])
    }
}

private extension CharactersViewController {
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
      let indexPathsForVisibleRows = charactersTableView.indexPathsForVisibleRows ?? []
      let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
      return Array(indexPathsIntersection)
    }
}
