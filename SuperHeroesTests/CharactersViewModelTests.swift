//
//  CharactersViewModelTests.swift
//  SuperHeroesTests
//
//  Created by Qasim Ahmed on 19/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import XCTest
@testable import SuperHeroes

class CharactersViewModelTests: XCTestCase {
    var mockMarvelRestClient: MockMarvelRestClient!
    var sut: CharactersViewModel!

    override func setUp() {
        super.setUp()
        mockMarvelRestClient = MockMarvelRestClient()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
