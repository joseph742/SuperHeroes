//
//  CharacterDescriptionViewControllerTest.swift
//  SuperHeroesTests
//
//  Created by Joseph Umoru on 22/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import XCTest
@testable import SuperHeroes

/*
 Description: A subclass of the XCTestCase class
 property1: sut
 property2: viewModel
 method2: setUp
 method3: tearDown
 method4: testCharacterDescriptionViewControllerRendering
 */

class CharacterDescriptionViewControllerTest: XCTestCase {
    var sut: CharacterDescriptionViewController!
    var viewModel: CharacterDescriptionViewControllerViewModel!

    override func setUp() {
        super.setUp()
        
        let resultData = PagedCharacterResponse.stub().data.results[0]
        viewModel = CharacterDescriptionViewControllerViewModel(result: resultData)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "characterDescriptionViewController") as? CharacterDescriptionViewController
        sut.viewModel = self.viewModel
        sut.loadView()
        sut.viewDidLoad()
    }

    override func tearDown() {
        super.tearDown()
    }

    /*
     Description: tests if the view objects of the CharacterDescriptionViewController are set with values
     */
    func testCharacterDescriptionViewControllerRendering() {
        XCTAssertEqual(sut.characterNameLabel.text, "3-D Man")
        XCTAssertEqual(sut.characterDescriptionLabel.text, "Character description not available")
        XCTAssertEqual(sut.viewModel.characterImageUrl, self.viewModel.characterImageUrl)
    }

}
