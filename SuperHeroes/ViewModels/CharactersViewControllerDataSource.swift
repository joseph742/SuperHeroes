//
//  CharactersViewControllerDataSource.swift
//  SuperHeroes
//
//  Created by Qasim Ahmed on 20/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import Foundation
import UIKit

class CharactersViewControllerDataSource: NSObject, UITableViewDataSource {
    
    private var viewModel: CharactersViewModelProtocol!
    private let reusableIdentifier: String!
    
    init(viewModel: CharactersViewModelProtocol, reusableIdentifier: String) {
        self.viewModel = viewModel
        self.reusableIdentifier = reusableIdentifier
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return viewModel.totalCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableIdentifier, for: indexPath) as! CharacterTableViewCell
        if isLoadingCell(for: indexPath) {
          cell.configure(with: .none)
        } else {
          cell.configure(with: viewModel.character(at: indexPath.row))
        }
        return cell
    }
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
      return indexPath.row >= viewModel.currentCount
    }
}
