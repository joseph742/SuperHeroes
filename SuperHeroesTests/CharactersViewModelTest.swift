//
//  CharactersViewModelTest.swift
//  SuperHeroesTests
//
//  Created by Joseph Umoru on 21/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import XCTest
@testable import SuperHeroes

/*
 Description: A subclass of the XCTestCase class
 property1: sut
 property2: charactersViewControllerDataSource
 property3: characterViewController
 method1: setUp
 method2: tearDown
 method3: testFetchCharactersWasCalled
 method4: testDeleteAllCharactersWasCalled
 method5: testSearchCharactersWasCalled
 */

class CharactersViewModelTest: XCTestCase {
    var sut: MockCharactersViewModel!
    var charactersViewControllerDataSource: CharactersViewControllerDataSource!
    var characterViewController: CharactersViewController!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.characterViewController = storyboard.instantiateViewController(withIdentifier: "charactersViewController") as? CharactersViewController
        self.characterViewController.loadView()
        self.characterViewController.viewDidLoad()
        sut = MockCharactersViewModel()
        sut.fetchCharacters()
        charactersViewControllerDataSource = CharactersViewControllerDataSource(viewModel: sut, reusableIdentifier: "characterTableViewCell")
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    /*
     Description: tests if the fetchCharacters method of the CharactersViewModel was called
     */
    func testFetchCharactersWasCalled() {
        sut.fetchCharacters()
        let tablewView = characterViewController.charactersTableView!
        tablewView.dataSource = charactersViewControllerDataSource
        tablewView.reloadData()
        XCTAssertTrue(sut.isFetchCharactersCalled)
        XCTAssertEqual(charactersViewControllerDataSource.tableView(tablewView, numberOfRowsInSection: 0), sut.totalCount)
    }
    
    /*
     Description: tests if the deleteAllCharacters method of the CharactersViewModel was called
     */
    func testDeleteAllCharactersWasCalled() {
        sut.fetchCharacters()
        let tablewView = characterViewController.charactersTableView!
        tablewView.dataSource = charactersViewControllerDataSource
        tablewView.reloadData()
        sut.deleteAllCharacters()
        tablewView.reloadData()
        XCTAssertTrue(sut.isDeleteAllCharactersCalled)
        XCTAssertEqual(charactersViewControllerDataSource.tableView(tablewView, numberOfRowsInSection: 0), 0)
    }
    
    /*
     Description: tests if the searchCharacter method of the CharactersViewModel was called
     */
    func testSearchCharactersWasCalled() {
        sut.fetchCharacters()
        let tablewView = characterViewController.charactersTableView!
        tablewView.dataSource = charactersViewControllerDataSource
        tablewView.reloadData()
        sut.deleteAllCharacters()
        tablewView.reloadData()
        sut.searchCharacter(searchString: "3-D Man")
        tablewView.reloadData()
        XCTAssertTrue(sut.isSearchCharactersCalled)
        XCTAssertEqual(charactersViewControllerDataSource.tableView(tablewView, numberOfRowsInSection: 0), sut.totalCount)
    }

}
