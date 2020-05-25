//
//  CharactersViewControllerDataSourceTest.swift
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
 property3: characterViewController
 method1: setUp
 method2: tearDown
 method3: testCharactersTableViewHasOneSection
 method4: testCharactersTableViewNumberOfRowsAreTheCharactersCount
 method5: testCharactersTableViewRowShowsCorrectCharacter
 */

class CharactersViewControllerDataSourceTest: XCTestCase {
    var sut: CharactersViewControllerDataSource!
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
        sut = CharactersViewControllerDataSource(viewModel: viewModel, reusableIdentifier: "characterTableViewCell")
    }

    override func tearDown() {
        super.tearDown()
    }
    
    /*
     Description: tests for the number of sections
     */

    func testCharactersTableViewHasOneSection() {
         let tablewView = UITableView()
         tablewView.dataSource = sut
         let numberOfSections = tablewView.numberOfSections
         XCTAssertEqual(1, numberOfSections)
     }
    
    
    /*
     Description: tests for the numberofRows
     */
    func testCharactersTableViewNumberOfRowsAreTheCharactersCount() {
        let tablewView = UITableView()
        tablewView.dataSource = sut
        tablewView.reloadData()
        let numberOfRows = tablewView.numberOfRows(inSection: 0)
        XCTAssertEqual(viewModel.totalCount, numberOfRows)
    }
    
    /*
     Description: tests for the cell label text
     */
    func testCharactersTableViewRowShowsCorrectCharacter() {
        let tablewView = characterViewController.charactersTableView!
        tablewView.dataSource = sut
        tablewView.reloadData()
        let cell = tablewView.cellForRow(at: IndexPath(row: 0, section: 0)) as! CharacterTableViewCell
        XCTAssertEqual("3-D Man", cell.characterNameLabel.text!)
    }

}
