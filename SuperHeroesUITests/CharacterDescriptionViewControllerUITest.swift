//
//  CharacterDescriptionViewControllerUITest.swift
//  SuperHeroesUITests
//
//  Created by Qasim Ahmed on 23/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import XCTest

class CharacterDescriptionViewControllerUITest: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testcharacterDescriptionViewControllerView() {
        XCTAssertTrue(app.isDisplayingOnboarding)
        let firstCell = app.tables["CharactersTableView"].cells.element(matching: .cell, identifier: "CharacterTableViewCell")
        let existencePredicate = NSPredicate(format: "exists == 1")
        let expectationEval = expectation(for: existencePredicate, evaluatedWith: firstCell, handler: nil)
        let waiter = XCTWaiter.wait(for: [expectationEval], timeout: 10.0)
        XCTAssert(XCTWaiter.Result.completed == waiter, "Test Case Failed.")
        firstCell.firstMatch.tap()
        let keyImage = app.otherElements["DescriptionView"]
        XCTAssertTrue(keyImage.exists, "CharacterDescriptionView exist")
    }

}
