//
//  CharactersViewControllerTableViewDelegate.swift
//  SuperHeroes
//
//  Created by Qasim Ahmed on 20/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import Foundation
import UIKit

class CharactersViewControllerTableViewDelegate: NSObject, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let characterCell = cell as? CharacterTableViewCell {
            characterCell.characterImageView.kf.cancelDownloadTask()
        }
    }
}
