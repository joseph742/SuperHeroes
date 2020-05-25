//
//  CharacterViewControllerSearchResultsUpdating.swift
//  SuperHeroes
//
//  Created by Joseph Umoru on 21/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import Foundation
import UIKit

/*
 Description: Conforms to the UISearchResultsUpdating protocol and a subclass of NSObject
 property1: delegate
 property2: viewModel
 method1: init
        parameter1: viewModel
        parameter2: delegate
 method2: updateSearchResults
        parameter1: searchController
 */
class CharacterViewControllerSearchResultsUpdating: NSObject, UISearchResultsUpdating {
    private weak var delegate: CharactersViewModelDelegate!
    private var viewModel: CharactersViewModelProtocol!
    
    init(viewModel: CharactersViewModelProtocol, delegate: CharactersViewModelDelegate) {
        self.viewModel = viewModel
        self.delegate = delegate
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchBarText = searchController.searchBar.text, searchBarText.count > 0 {
            viewModel.deleteAllCharacters()
            viewModel.searchCharacter(searchString: searchBarText)
        } else {
            viewModel.searchQuery = nil
            viewModel.deleteAllCharacters()
            viewModel.fetchCharacters()
        }
    }
}
