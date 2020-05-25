//
//  CharactersViewControllerTableViewDelegate.swift
//  SuperHeroes
//
//  Created by Joseph Umoru on 20/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import Foundation
import UIKit

/*
 Description: Conforms to the UITableViewDelegate protocol and a subclass of NSObject
 method1: tableView
        parameter1: tableView
        parameter2: cell
        parameter3: indexPath
 */

class CharactersViewControllerTableViewDelegate: NSObject, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let characterCell = cell as? CharacterTableViewCell {
            characterCell.characterImageView.kf.cancelDownloadTask()
        }
    }
}
