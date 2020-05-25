//
//  CharactersViewControllerTests.swift
//  SuperHeroesTests
//
//  Created by Joseph Umoru on 20/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import XCTest
@testable import SuperHeroes

/*
 Description: A subclass of the XCTestCase class
 property1: sut
 property2: viewModel
 method1: setUp
 method2: tearDown
 method3: testSetsTableView
 method4: testSetsDataSource
 */

class CharactersViewControllerTests: XCTestCase {
    
    var sut: CharactersViewController!
    var viewModel: MockCharactersViewModel!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.sut = storyboard.instantiateViewController(withIdentifier: "charactersViewController") as? CharactersViewController
        self.sut.loadView()
        self.sut.viewDidLoad()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /*
     Description: Tests if the CharactersViewController table is not nil
     */
    func testSetsTableView() {
        XCTAssertNotNil(sut.charactersTableView)
    }
    
    func testSetsDataSource() {
        viewModel = MockCharactersViewModel()
        viewModel.fetchCharacters()
        let charactersDataSource = CharactersViewControllerDataSource(viewModel: viewModel, reusableIdentifier: "characterTableViewCell")
        sut.charactersTableView.dataSource = charactersDataSource
        XCTAssertTrue(sut.charactersTableView.dataSource === charactersDataSource)
    }

}
