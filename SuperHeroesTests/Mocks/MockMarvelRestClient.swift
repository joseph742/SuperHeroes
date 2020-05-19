//
//  MockMarvelRestClient.swift
//  SuperHeroesTests
//
//  Created by Qasim Ahmed on 19/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import Foundation
@testable import SuperHeroes

class MockMarvelRestClient: MarvelRestClientProtocol {
    var shouldReturnError = false
    var isFetchCharactersCalled = false
    
    func reset() {
        shouldReturnError = false
        isFetchCharactersCalled = false
    }
    
    convenience init(){
        self.init(false)
    }
    
    init(_ shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    let mockFetchCharacterResponse = PagedCharacterResponse.stub()
    
    func fetchCharacters(with url: URL?, page: Int, completion: @escaping (NetworkResult<PagedCharacterResponse, NetworkResponseError>) -> Void) {
        isFetchCharactersCalled = true
        
        if shouldReturnError {
            completion(NetworkResult.failure(NetworkResponseError.network))
        } else {
            completion(NetworkResult.success(mockFetchCharacterResponse))
        }
    }
}
