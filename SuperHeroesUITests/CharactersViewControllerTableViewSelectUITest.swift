//
//  CharactersViewControllerTableViewSelectUITest.swift
//  SuperHeroesUITests
//
//  Created by Qasim Ahmed on 23/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import XCTest

class CharactersViewControllerTableViewSelectUITest: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testForCharactersTableViewCellSelection() {
        XCTAssertTrue(app.isDisplayingOnboarding)
        let firstCell = app.tables["CharactersTableView"].cells.element(matching: .cell, identifier: "CharacterTableViewCell")
        let predicate = NSPredicate(format: "exists == 1")
        let expectationEval = expectation(for: predicate, evaluatedWith: firstCell, handler: nil)
        let waiter = XCTWaiter.wait(for: [expectationEval], timeout: 10.0)
        XCTAssert(XCTWaiter.Result.completed == waiter, "Test Case Failed.")
        firstCell.firstMatch.tap()
    }

}
