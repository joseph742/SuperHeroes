//
//  MockCharactersViewModel.swift
//  SuperHeroesTests
//
//  Created by Qasim Ahmed on 20/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import Foundation
@testable import SuperHeroes

class MockCharactersViewModel: CharactersViewModelProtocol {
    var isDeleteAllCharactersCalled = false
    var isFetchCharactersCalled = false
    var isSearchCharactersCalled = false
    
    private var characters: [Result] = []
    private var total = 0
    var searchQuery: String?
    
    var totalCount: Int {
      return total
    }
    
    var currentCount: Int {
      return characters.count
    }
    
    func character(at index: Int) -> Result {
        return characters[index]
    }
    
    func deleteAllCharacters() {
        isDeleteAllCharactersCalled = true
        self.total = 0
        characters.removeAll()
    }
    
    func fetchCharacters() {
        isFetchCharactersCalled = true
        let characterData = PagedCharacterResponse.stub()
        self.characters.append(contentsOf: characterData.data.results)
        self.total = characterData.data.total
    }
    
    func searchCharacter(searchString: String) {
        isSearchCharactersCalled = true
        searchQuery = searchString
        let characterData = PagedCharacterResponse.stub()
        self.characters.append(contentsOf: characterData.data.results)
        self.total = characterData.data.total
    }
    
}
