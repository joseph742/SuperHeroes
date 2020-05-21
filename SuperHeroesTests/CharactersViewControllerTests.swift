//
//  CharactersViewControllerTests.swift
//  SuperHeroesTests
//
//  Created by Qasim Ahmed on 20/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import XCTest
@testable import SuperHeroes

class CharactersViewControllerTests: XCTestCase {
    
    var viewControllerUnderTest: CharactersViewController!
    var viewModel: MockCharactersViewModel!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.viewControllerUnderTest = storyboard.instantiateViewController(withIdentifier: "charactersViewController") as? CharactersViewController
        self.viewControllerUnderTest.loadView()
        self.viewControllerUnderTest.viewDidLoad()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSetsTableView() {
        XCTAssertNotNil(viewControllerUnderTest.charactersTableView)
    }
    
    func testSetsDataSource() {
        viewModel = MockCharactersViewModel()
        viewModel.fetchCharacters()
        let charactersDataSource = CharactersViewControllerDataSource(viewModel: viewModel, reusableIdentifier: "characterTableViewCell")
        viewControllerUnderTest.charactersTableView.dataSource = charactersDataSource
        XCTAssertTrue(viewControllerUnderTest.charactersTableView.dataSource === charactersDataSource)
    }

}
