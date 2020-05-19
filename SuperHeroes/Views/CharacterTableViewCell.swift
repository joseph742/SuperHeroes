//
//  CharacterTableViewCell.swift
//  SuperHeroes
//
//  Created by Joseph Umoru on 14/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import UIKit
import Kingfisher

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
