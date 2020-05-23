//
//  CharacterDescriptionViewControllerTextContainerUITest.swift
//  SuperHeroesUITests
//
//  Created by Qasim Ahmed on 23/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import XCTest

class CharacterDescriptionViewControllerTextContainerUITest: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testcharacterDescriptionViewControllerTextContainer() {
        XCTAssertTrue(app.isDisplayingOnboarding)
        let firstCell = app.tables["CharactersTableView"].cells.element(matching: .cell, identifier: "CharacterTableViewCell")
        let existencePredicate = NSPredicate(format: "exists == 1")
        let expectationEval = expectation(for: existencePredicate, evaluatedWith: firstCell, handler: nil)
        let waiter = XCTWaiter.wait(for: [expectationEval], timeout: 10.0)
        XCTAssert(XCTWaiter.Result.completed == waiter, "Test Case Failed.")
        firstCell.firstMatch.tap()
        let textContainer = app.otherElements["DescriptionView"].otherElements["textContainer"]
        let nameLabel = app.otherElements["DescriptionView"].otherElements["textContainer"].staticTexts["nameLabel"]
        let descriptionLabel = app.otherElements["DescriptionView"].otherElements["textContainer"].staticTexts["descriptionLabel"]
        XCTAssertTrue(textContainer.exists, "Text container exist")
        XCTAssertTrue(nameLabel.exists, "Name label exist")
        XCTAssertTrue(descriptionLabel.exists, "Description exist")
    }

}
