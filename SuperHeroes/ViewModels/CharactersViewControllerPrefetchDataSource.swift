//
//  CharactersViewControllerPrefetchDataSource.swift
//  SuperHeroes
//
//  Created by Joseph Umoru on 20/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import Foundation
import UIKit

/*
 Description: Conforms to the UITableViewDataSourcePrefetching protocol and a subclass of NSObject
 property1: viewModel
 method1: init
        paramter1: viewModel
 method2: tableView
        parameter1: tableView
        parameter2: indexPaths
 method3: isLoadingCell
        parameter1: indexPath
 */

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
