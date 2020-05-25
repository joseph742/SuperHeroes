//
//  MockMarvelRestClient.swift
//  SuperHeroesTests
//
//  Created by Joseph Umoru on 19/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import Foundation
@testable import SuperHeroes

/*
 Description: A mock class that conforms to the MarvelRestClientProtocol protocol
 property1: shouldReturnError
 property2: isFetchCharactersCalled
 property5: mockFetchCharacterResponse
 method1: reset
 method2: convenience init
 method3: init
        parameters1: shouldReturnError
 method4: fetchCharacters
 */

class MockMarvelRestClient: MarvelRestClientProtocol {
    var shouldReturnError = false
    var isFetchCharactersCalled = false
    let mockFetchCharacterResponse = PagedCharacterResponse.stub()
    
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
    
    /*
     Description: to simulate either success or failure of the fetchCharacters method
     */
    func fetchCharacters(with url: URL?, page: Int, completion: @escaping (NetworkResult<PagedCharacterResponse, NetworkResponseError>) -> Void) {
        isFetchCharactersCalled = true
        
        if shouldReturnError {
            completion(NetworkResult.failure(NetworkResponseError.network))
        } else {
            completion(NetworkResult.success(mockFetchCharacterResponse))
        }
    }
}
