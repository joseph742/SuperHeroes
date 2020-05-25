//
//  CharacterDescriptionViewController.swift
//  SuperHeroes
//
//  Created by Joseph Umoru on 14/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import UIKit
import Kingfisher

/*
 Description: Manages interactions between the view and the underlying data
 property1: viewModel (implicitly unwrapped optionals)
 */

class CharacterDescriptionViewController: UIViewController {
    @IBOutlet weak var characterLargeImage: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterDescriptionLabel: UILabel!
    
    var viewModel: CharacterDescriptionViewControllerViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.processData()
        characterNameLabel.text = viewModel.characterName
        characterDescriptionLabel.text = viewModel.characterDescription
        if let url = viewModel.characterImageUrl {
            characterLargeImage.kf.setImage(with: url)
        }
    }

}
