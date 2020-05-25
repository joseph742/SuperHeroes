//
//  CharacterDescriptionViewControllerViewModel.swift
//  SuperHeroes
//
//  Created by Joseph Umoru on 21/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import Foundation

/*
 Description: Transform model information into values that can be displayed on the view.
 property1: result
 property2: name
 property3: description
 property4: url
 property5: characterName
 property6: characterDescription
 property7: characterImageUrl
 method1: init
        parameter1: result
 method2: processData
 */
class CharacterDescriptionViewControllerViewModel {
    private let result: Result
    private var name = "Character name"
    private var description = "Character description not available"
    private var url: URL?
    
    /*
     Description: sets the initial value for the stored property result
     */
    init(result: Result) {
        self.result = result
    }
    
    /*
     Description: returns character name
     */
    var characterName: String {
      return name
    }
    
    /*
     Description: return character description
     */
    var characterDescription: String {
      return description
    }
    
    /*
     Description: return the character image url
     */
    var characterImageUrl: URL? {
      return url
    }
    
    /*
     Description: sets the initial value for the property name, description, and url
     */
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
