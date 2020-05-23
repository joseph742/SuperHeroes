//
//  CharacterDescriptionViewControllerSnapshotTest.swift
//  SuperHeroesTests
//
//  Created by Qasim Ahmed on 23/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import XCTest
import FBSnapshotTestCase
@testable import SuperHeroes

class CharacterDescriptionViewControllerSnapshotTest: FBSnapshotTestCase {
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
    
    func testSetsDataSource() {
        FBSnapshotVerifyView(self.characterDescriptionViewControllerUnderTest.view)
    }

}
