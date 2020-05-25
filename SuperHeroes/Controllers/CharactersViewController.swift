//
//  CharactersViewController.swift
//  SuperHeroes
//
//  Created by Joseph Umoru on 14/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import UIKit

/*
 Description: Manages interactions between the view and the underlying data
 property1: CellIdentifiers (private)
 property2: charactersTableView
 property3: activityIndicator
 property4: viewModel
 property5: tableViewDataSource
 property6: tableViewDelegate
 property7: tableViewPrefetchDataSource
 property8: tableViewSearchResultsUpdating
 */

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
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isAccessibilityElement = false
        view.accessibilityIdentifier = "onboardingView"
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showDescriptionSegue", let indexPath = charactersTableView.indexPathForSelectedRow, let characterDetailViewController = segue.destination as? CharacterDescriptionViewController, self.viewModel.currentCount > 0
          else {
            return
        }
        
        let singleResult = self.viewModel.character(at: indexPath.row)
        let descriptionViewModel = CharacterDescriptionViewControllerViewModel(result: singleResult)
        characterDetailViewController.viewModel = descriptionViewModel
    }

}

/*
 Description: Implements the CharactersViewModelDelegate protocol requirements
 */

extension CharactersViewController: CharactersViewModelDelegate {
    /*
     Description: reloads the UITableView
     */
    func onReloadTableViewData() {
        charactersTableView.reloadData()
    }
    
    /*
     Description: gets called by the viewModel after a successful response from the MarvelRestClient, reloads the UIVewTable ans Stop the activity container from spining
     parameters1: newIndexPathsToReload
     */
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
    
    /*
     Description: gets called by the viewModel after an unsuccessful response from the MarvelRestClient, shows the UIAlertController with the error message.
     parameters1: reason
     */
    func onFetchFailed(with reason: String) {
      activityIndicator.stopAnimating()
      
      let title = "Warning"
      let action = UIAlertAction(title: "OK", style: .default)
      showAlertView(with: title , message: reason, actions: [action])
    }
}

/*
 Description: calculates the cells of the table view that you need to reload when you receive a new page.
 parameters1: indexPaths
 */

private extension CharactersViewController {
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
      let indexPathsForVisibleRows = charactersTableView.indexPathsForVisibleRows ?? []
      let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
      return Array(indexPathsIntersection)
    }
}
