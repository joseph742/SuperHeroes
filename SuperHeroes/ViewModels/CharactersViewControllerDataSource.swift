//
//  CharactersViewControllerDataSource.swift
//  SuperHeroes
//
//  Created by Joseph Umoru on 20/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import Foundation
import UIKit

/*
 Description: Conforms to the UITableViewDataSource protocol and a subclass of NSObject
 propery1: viewModel
 property2: reusableIdentifier
 method1: init
        paramter1: viewModel
        parameter2: reusableIdentifier
 method2: tableView
        parameter1: tableView
        parameter2: section
 method3: tableView
        parameter1: tableView
        parameter2: indexPath
 method4: isLoadingCell
        parameter1: indexPath
 */

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
