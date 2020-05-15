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
    private var shouldShowLoadingCell = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.color = WallapopTheme.colorChoice
        activityIndicator.startAnimating()
        
        charactersTableView.isHidden = true
        charactersTableView.separatorColor = WallapopTheme.colorChoice
        charactersTableView.dataSource = self
        charactersTableView.prefetchDataSource = self
        
        viewModel = CharactersViewModel(delegate: self)
        
        viewModel.fetchCharacters()
    }

}

extension CharactersViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.totalCount
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.list, for: indexPath) as! CharacterTableViewCell
    if isLoadingCell(for: indexPath) {
      cell.configure(with: .none)
    } else {
      cell.configure(with: viewModel.character(at: indexPath.row))
    }
    return cell
  }
}

extension CharactersViewController: CharactersViewModelDelegate {
    
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

extension CharactersViewController: UITableViewDataSourcePrefetching {
  func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    if indexPaths.contains(where: isLoadingCell) {
      viewModel.fetchCharacters()
    }
  }
}

private extension CharactersViewController {
  func isLoadingCell(for indexPath: IndexPath) -> Bool {
    return indexPath.row >= viewModel.currentCount
  }

  func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
    let indexPathsForVisibleRows = charactersTableView.indexPathsForVisibleRows ?? []
    let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
    return Array(indexPathsIntersection)
  }
}
