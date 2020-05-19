//
//  MarvelRestClientProtocol.swift
//  SuperHeroes
//
//  Created by Qasim Ahmed on 19/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import Foundation

protocol MarvelRestClientProtocol {
    func fetchCharacters(with url: URL?, page: Int, completion: @escaping (NetworkResult<PagedCharacterResponse, NetworkResponseError>) -> ())
}
