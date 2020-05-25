//
//  MarvelRestClientParserTests.swift
//  SuperHeroesTests
//
//  Created by Joseph Umoru on 18/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import XCTest
@testable import SuperHeroes

/*
 Description: A subclass of the XCTestCase class
 property1: sut
 property2: url
 method1: setUp
 method2: testFechCharactersWasCalled
 method3: testFetchCharacters
 */

class MarvelRestClientParserTests: XCTestCase {
    var sut: MockMarvelRestClient!
    var url: URL?

    override func setUp() {
        super.setUp()
        sut = MockMarvelRestClient()
        url = Endpoint.getRequest().url
    }
    
    override func tearDown() {
        sut = nil
        url = nil
    }
    
    
    /*
     Description: tests if the fetchCharacters method of the MarvelRestClient is called
     */
    func testFechCharactersWasCalled() {
        let expectation = self.expectation(description: "fetch characters parse expectation")
        sut.fetchCharacters(with: url, page: 0) { (result) in
            XCTAssertTrue(self.sut.isFetchCharactersCalled)
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    
    /*
     Description: tests if the fetchCharacters method of the MarvelRestClient return data from the completion
     */
    func testFetchCharacters() {
        let expectation = self.expectation(description: "fetch characters parse expectation")
        
        
        sut.fetchCharacters(with: url, page: 0) { result in
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
