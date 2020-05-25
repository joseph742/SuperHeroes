//
//  CharacterTableViewCell.swift
//  SuperHeroes
//
//  Created by Joseph Umoru on 14/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import UIKit
import Kingfisher

/*
 Description: A subclass of the UITableViewCell class
 property1: characterImageView
 property2 activityIndicator
 property3 characterNameLabel
 method1: prepareForReuse
 method2: awakeFromNib
 method3: setSelected
        parameter1: selected
        parameter2: animated
 method3: configure
        parameter: resultData
 */

class CharacterTableViewCell: UITableViewCell {
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var characterNameLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        configure(with: .none)
        characterImageView.image = UIImage(named: "avatar")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator.color = WallapopTheme.colorChoice
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /*
     Description: sets the value for the view objects in the CharacterTableViewCell
     */
    func configure(with resultData: Result?) {
      if let result = resultData {
        characterNameLabel?.text = result.name
        let imageURL = result.thumbnail.path + "/portrait_small." + result.thumbnail.thumbnailExtension
        guard let imageUrl = URL(string: imageURL) else {
            return
        }
        
        characterImageView.kf.setImage(with: imageUrl)
        activityIndicator.stopAnimating()
      } else {
        activityIndicator.startAnimating()
      }
    }

}
