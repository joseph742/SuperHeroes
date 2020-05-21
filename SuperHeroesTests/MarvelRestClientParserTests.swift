//
//  MarvelRestClientParserTests.swift
//  SuperHeroesTests
//
//  Created by Joseph Umoru on 18/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import XCTest
@testable import SuperHeroes

class MarvelRestClientParserTests: XCTestCase {
    var mockMarvelRestClient: MockMarvelRestClient!
    var url: URL?

    override func setUp() {
        super.setUp()
        mockMarvelRestClient = MockMarvelRestClient()
        url = Endpoint.getRequest().url
    }
    
    override func tearDown() {
        mockMarvelRestClient = nil
        url = nil
    }
    
    func testFechCharactersWasCalled() {
        let expectation = self.expectation(description: "fetch characters parse expectation")
        mockMarvelRestClient.fetchCharacters(with: url, page: 0) { (result) in
            XCTAssertTrue(self.mockMarvelRestClient.isFetchCharactersCalled)
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testFetchCharacters() {
        let expectation = self.expectation(description: "fetch characters parse expectation")
        
        
        mockMarvelRestClient.fetchCharacters(with: url, page: 0) { result in
            switch result {
            case .failure(let error):
                XCTFail(error.localizedDescription)
            case .success(let response):
                XCTAssertEqual(response.data.results.count, 1)
                XCTAssertEqual(response.data.results.first?.name, "3-D Man")
                XCTAssertNotNil(response)
                expectation.fulfill()
            }
        }
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }

}
