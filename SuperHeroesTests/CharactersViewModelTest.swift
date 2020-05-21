//
//  CharactersViewModelTest.swift
//  SuperHeroesTests
//
//  Created by Qasim Ahmed on 21/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import XCTest
@testable import SuperHeroes

class CharactersViewModelTest: XCTestCase {
    var charactersViewModelUnderTest: MockCharactersViewModel!
    var charactersViewControllerDataSource: CharactersViewControllerDataSource!
    var characterViewController: CharactersViewController!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.characterViewController = storyboard.instantiateViewController(withIdentifier: "charactersViewController") as? CharactersViewController
        self.characterViewController.loadView()
        self.characterViewController.viewDidLoad()
        charactersViewModelUnderTest = MockCharactersViewModel()
        charactersViewModelUnderTest.fetchCharacters()
        charactersViewControllerDataSource = CharactersViewControllerDataSource(viewModel: charactersViewModelUnderTest, reusableIdentifier: "characterTableViewCell")
    }

    override func tearDown() {
        super.tearDown()
    }

    func testFetchCharactersWasCalled() {
        charactersViewModelUnderTest.fetchCharacters()
        let tablewView = characterViewController.charactersTableView!
        tablewView.dataSource = charactersViewControllerDataSource
        tablewView.reloadData()
        XCTAssertTrue(charactersViewModelUnderTest.isFetchCharactersCalled)
        XCTAssertEqual(charactersViewControllerDataSource.tableView(tablewView, numberOfRowsInSection: 0), charactersViewModelUnderTest.totalCount)
    }
    
    func testDeleAllCharactersWasCalled() {
        charactersViewModelUnderTest.fetchCharacters()
        let tablewView = characterViewController.charactersTableView!
        tablewView.dataSource = charactersViewControllerDataSource
        tablewView.reloadData()
        charactersViewModelUnderTest.deleteAllCharacters()
        tablewView.reloadData()
        XCTAssertEqual(charactersViewControllerDataSource.tableView(tablewView, numberOfRowsInSection: 0), 0)
        XCTAssertTrue(charactersViewModelUnderTest.isDeleteAllCharactersCalled)
    }
    
    func testSearchCharactersWasCalled() {
        charactersViewModelUnderTest.fetchCharacters()
        let tablewView = characterViewController.charactersTableView!
        tablewView.dataSource = charactersViewControllerDataSource
        tablewView.reloadData()
        XCTAssertEqual(charactersViewControllerDataSource.tableView(tablewView, numberOfRowsInSection: 0), charactersViewModelUnderTest.totalCount)
        charactersViewModelUnderTest.deleteAllCharacters()
        XCTAssertEqual(charactersViewControllerDataSource.tableView(tablewView, numberOfRowsInSection: 0), 0)
        tablewView.reloadData()
        charactersViewModelUnderTest.searchCharacter(searchString: "3-D Man")
        tablewView.reloadData()
        XCTAssertTrue(charactersViewModelUnderTest.isSearchCharactersCalled)
        XCTAssertTrue(charactersViewModelUnderTest.isDeleteAllCharactersCalled)
        XCTAssertEqual(charactersViewControllerDataSource.tableView(tablewView, numberOfRowsInSection: 0), charactersViewModelUnderTest.totalCount)
    }

}
