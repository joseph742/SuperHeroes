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
    
    private var viewModel: CharacterDescriptionViewControllerViewModel
    
    init?(viewModel: CharacterDescriptionViewControllerViewModel, coder: NSCoder) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
