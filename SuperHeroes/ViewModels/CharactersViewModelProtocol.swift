//
//  CharactersViewModelProtocol.swift
//  SuperHeroes
//
//  Created by Joseph Umoru on 20/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import Foundation

/*
 Description: Defines the totalCount, currentCount, searchQuery properties and deleteAllCharacters, character, fetchCharacters, searchCharacter methods
 */

protocol CharactersViewModelProtocol {
    
    var totalCount: Int { get }
    var currentCount: Int { get }
    var searchQuery: String? { get set }
    func deleteAllCharacters()
    func character(at index: Int) -> Result
    func fetchCharacters()
    func searchCharacter(searchString: String)
}
