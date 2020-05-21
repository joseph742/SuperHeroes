//
//  CharactersViewControllerPrefetchDataSource.swift
//  SuperHeroes
//
//  Created by Qasim Ahmed on 20/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import Foundation
import UIKit

class CharactersViewControllerPrefetchDataSource: NSObject, UITableViewDataSourcePrefetching {
    private let viewModel: CharactersViewModelProtocol!
    
    init(viewModel: CharactersViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
      if indexPaths.contains(where: isLoadingCell) {
        if let queryString = viewModel.searchQuery {
            viewModel.searchCharacter(searchString: queryString)
        } else {
            viewModel.fetchCharacters()
        }
      }
    }
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
      return indexPath.row >= viewModel.currentCount
    }
}
