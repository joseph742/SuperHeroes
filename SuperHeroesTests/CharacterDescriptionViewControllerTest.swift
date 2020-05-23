//
//  CharacterDescriptionViewControllerTest.swift
//  SuperHeroesTests
//
//  Created by Qasim Ahmed on 22/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import XCTest
@testable import SuperHeroes

class CharacterDescriptionViewControllerTest: XCTestCase {
    var characterDescriptionViewControllerUnderTest: CharacterDescriptionViewController!
    var viewModel: CharacterDescriptionViewControllerViewModel!

    override func setUp() {
        super.setUp()
        
        let resultData = PagedCharacterResponse.stub().data.results[0]
        self.viewModel = CharacterDescriptionViewControllerViewModel(result: resultData)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.characterDescriptionViewControllerUnderTest = storyboard.instantiateViewController(withIdentifier: "characterDescriptionViewController") as? CharacterDescriptionViewController
        self.characterDescriptionViewControllerUnderTest.viewModel = self.viewModel
        self.characterDescriptionViewControllerUnderTest.loadView()
        self.characterDescriptionViewControllerUnderTest.viewDidLoad()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testCharacterDescriptionViewControllerRendering() {
        XCTAssertEqual(characterDescriptionViewControllerUnderTest.characterNameLabel.text, "3-D Man")
        XCTAssertEqual(characterDescriptionViewControllerUnderTest.characterDescriptionLabel.text, "Character description not available")
        XCTAssertEqual(characterDescriptionViewControllerUnderTest.viewModel.characterImageUrl, self.viewModel.characterImageUrl)
    }

}
