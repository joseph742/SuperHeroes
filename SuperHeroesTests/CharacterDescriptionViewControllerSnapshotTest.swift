//
//  CharacterDescriptionViewControllerSnapshotTest.swift
//  SuperHeroesTests
//
//  Created by Joseph Umoru on 23/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import XCTest
import FBSnapshotTestCase
@testable import SuperHeroes

/*
 Description: A subclass of the FBSnapshotTestCase class
 property1: sut
 property2: viewModel
 method1: setUp
 method3: tearDown
 method4: testCharacterDescriptionViewControllerScreenShot
 */

class CharacterDescriptionViewControllerSnapshotTest: FBSnapshotTestCase {
    var sut: CharacterDescriptionViewController!
    var viewModel: CharacterDescriptionViewControllerViewModel!

    override func setUp() {
        super.setUp()
        let resultData = PagedCharacterResponse.stub().data.results[0]
        self.viewModel = CharacterDescriptionViewControllerViewModel(result: resultData)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.sut = storyboard.instantiateViewController(withIdentifier: "characterDescriptionViewController") as? CharacterDescriptionViewController
        self.sut.viewModel = self.viewModel
    }

    override func tearDown() {
        super.tearDown()
    }
    
    /*
     Description: verify the screenshot with saved screenshot
     */
    func testCharacterDescriptionViewControllerScreenShot() {
        FBSnapshotVerifyView(self.sut.view)
    }

}
