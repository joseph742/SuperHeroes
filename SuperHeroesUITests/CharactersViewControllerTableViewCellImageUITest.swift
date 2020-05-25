//
//  CharactersViewControllerTableViewCellImageUITest.swift
//  SuperHeroesUITests
//
//  Created by Joseph Umoru on 23/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import XCTest

/*
 Description: A subclass of the XCTestCase class
 property1: app
 method1: setUp
 method2: tearDown
 method3: testForCharactersTableViewCellImageExistenceOnTable
*/

class CharactersViewControllerTableViewCellImageUITest: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    /*
     Description: Tests for the existence of a imageView in the CharactersTableView cell
     */

    func testForCharactersTableViewCellImageExistenceOnTable() {
        XCTAssertTrue(app.isDisplayingOnboarding)
        let firstCell = app.tables["CharactersTableView"].cells.element(matching: .cell, identifier: "CharacterTableViewCell")
        let predicate = NSPredicate(format: "exists == 1")
        let expectationEval = expectation(for: predicate, evaluatedWith: firstCell, handler: nil)
        let waiter = XCTWaiter.wait(for: [expectationEval], timeout: 10.0)
        XCTAssert(XCTWaiter.Result.completed == waiter, "Test Case Failed.")
        let keyLabel = firstCell.images["characterImage"]
        XCTAssertTrue(keyLabel.exists, "characterImage label not exist.")
    }

}
