//
//  CharactersViewModelProtocol.swift
//  SuperHeroes
//
//  Created by Qasim Ahmed on 20/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import Foundation

protocol CharactersViewModelProtocol {
    
    var totalCount: Int { get }
    var currentCount: Int { get }
    var searchQuery: String? { get set }
    func deleteAllCharacters()
    func character(at index: Int) -> Result
    func fetchCharacters()
    func searchCharacter(searchString: String)
}
