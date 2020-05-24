//
//  CharacterDescriptionViewControllerViewModel.swift
//  SuperHeroes
//
//  Created by Qasim Ahmed on 21/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import Foundation

protocol CharacterDescriptionViewControllerViewModelProtocol {
    var characterName: String { get }
    var characterDescription: String { get }
    var characterImageUrl: URL? { get }
    func processData()
}

class CharacterDescriptionViewControllerViewModel: CharacterDescriptionViewControllerViewModelProtocol  {
    private let result: Result
    private var name = "Character name"
    private var description = "Character description not available"
    private var url: URL?
    
    init(result: Result) {
        self.result = result
    }
    
    var characterName: String {
      return name
    }
    
    var characterDescription: String {
      return description
    }
    
    var characterImageUrl: URL? {
      return url
    }
    
    func processData() {
        if self.result.name.count > 0 {
            self.name = self.result.name
        }
        
        if self.result.resultDescription.count > 0 {
            self.description = self.result.resultDescription
        }
        
        let urlString = self.result.thumbnail.path + "/portrait_medium." + self.result.thumbnail.thumbnailExtension
        self.url = URL(string: urlString)
    }
}
