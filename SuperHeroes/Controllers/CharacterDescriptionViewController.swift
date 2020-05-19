//
//  CharacterDescriptionViewController.swift
//  SuperHeroes
//
//  Created by Joseph Umoru on 14/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import UIKit
import Kingfisher

class CharacterDescriptionViewController: UIViewController {
    @IBOutlet weak var characterLargeImage: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterDescriptionLabel: UILabel!
    
    var result: Result? {
      didSet {
        configureView()
      }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        if let singleCharacter = result, let characterName = characterNameLabel, let characterDescription = characterDescriptionLabel, let characterImage = characterLargeImage {
            characterName.text = singleCharacter.name
            characterDescription.text = singleCharacter.resultDescription
            
            guard let imageUrl = URL(string: singleCharacter.thumbnail.path + "/portrait_medium." + singleCharacter.thumbnail.thumbnailExtension) else {
                return
                }
            characterImage.kf.setImage(with: imageUrl)
        }
    }

}
