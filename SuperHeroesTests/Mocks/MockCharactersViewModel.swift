//
//  MockCharactersViewModel.swift
//  SuperHeroesTests
//
//  Created by Joseph Umoru on 20/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import Foundation
@testable import SuperHeroes

/*
 Description: Description: a mock class that conforms to the MarvelRestClientProtocol protocol
 property1: isDeleteAllCharactersCalled
 property2: isFetchCharactersCalled
 property3: isSearchCharactersCalled
 property4: characters
 property5: total
 property6: searchQuery
 property7: totalCount
 property8: currentCount
 method1: character
 method2: deleteAllCharacters
 method3: fetchCharacters
 method4: searchCharacter
 */

class MockCharactersViewModel: CharactersViewModelProtocol {
    var isDeleteAllCharactersCalled = false
    var isFetchCharactersCalled = false
    var isSearchCharactersCalled = false
    
    private var characters: [Result] = []
    private var total = 0
    var searchQuery: String?
    
    /*
     Description: return the total number of elements in the character endpoint from the API
     */
    var totalCount: Int {
      return total
    }
    
    /*
     Description: return the current count of elements in the array of characters currently available
     */
    var currentCount: Int {
      return characters.count
    }
    
    /*
     Description: returns the character at the specidied index from the parameter
     */
    func character(at index: Int) -> Result {
        return characters[index]
    }
    
    /*
     Description: removes all the elements of the characters array, sets the value of total.
     */
    func deleteAllCharacters() {
        isDeleteAllCharactersCalled = true
        self.total = 0
        characters.removeAll()
    }
    
    /*
     Description: returns a mock data of type PagedCharacterResponse
     */
    func fetchCharacters() {
        isFetchCharactersCalled = true
        let characterData = PagedCharacterResponse.stub()
        self.characters.append(contentsOf: characterData.data.results)
        self.total = characterData.data.total
    }
    
    
    /*
     Description: returns a mock data of type PagedCharacterResponse that matches the search query
     */
    func searchCharacter(searchString: String) {
        isSearchCharactersCalled = true
        searchQuery = searchString
        if searchString == "3-D Man" {
            let characterData = PagedCharacterResponse.stub()
            self.characters.append(contentsOf: characterData.data.results)
            self.total = characterData.data.total
        }
    }
    
}
