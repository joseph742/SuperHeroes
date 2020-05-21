//
//  CharactersViewControllerDataSourceTest.swift
//  SuperHeroesTests
//
//  Created by Qasim Ahmed on 20/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import XCTest
@testable import SuperHeroes

class CharactersViewControllerDataSourceTest: XCTestCase {
    var charactersViewControllerDataSourceUnderTest: CharactersViewControllerDataSource!
    var viewModel: MockCharactersViewModel!
    var characterViewController: CharactersViewController!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.characterViewController = storyboard.instantiateViewController(withIdentifier: "charactersViewController") as? CharactersViewController
        self.characterViewController.loadView()
        self.characterViewController.viewDidLoad()
        viewModel = MockCharactersViewModel()
        viewModel.fetchCharacters()
        charactersViewControllerDataSourceUnderTest = CharactersViewControllerDataSource(viewModel: viewModel, reusableIdentifier: "characterTableViewCell")
    }

    override func tearDown() {
        super.tearDown()
    }

    func testCharactersTableViewHasOneSection() {
         let tablewView = UITableView()
         tablewView.dataSource = charactersViewControllerDataSourceUnderTest
         let numberOfSections = tablewView.numberOfSections
         XCTAssertEqual(1, numberOfSections)
     }
    
    func testCharactersTableViewNumberOfRowsAreTheCharactersCount() {
        let tablewView = UITableView()
        tablewView.dataSource = charactersViewControllerDataSourceUnderTest
        tablewView.reloadData()
        let numberOfRows = tablewView.numberOfRows(inSection: 0)
        XCTAssertEqual(viewModel.totalCount, numberOfRows)
    }
    
    func testCharactersTableViewRowShowsCorrectCharacter() {
        let tablewView = characterViewController.charactersTableView!
        tablewView.dataSource = charactersViewControllerDataSourceUnderTest
        tablewView.reloadData()
        let cell = tablewView.cellForRow(at: IndexPath(row: 0, section: 0)) as! CharacterTableViewCell
        XCTAssertEqual("3-D Man", cell.characterNameLabel.text!)
    }

}
