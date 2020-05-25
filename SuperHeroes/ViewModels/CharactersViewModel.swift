//
//  CharactersViewModel.swift
//  SuperHeroes
//
//  Created by Joseph Umoru on 14/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import Foundation

/*
 Description: Defines the onReloadTableViewData, onFetchCompleted, onFetchFailed methods
 method1: onFetchCompleted
 parameter1: newIndexPathsToReload
 method2: onFetchFailed
 parameter2: reason
 */
protocol CharactersViewModelDelegate: class {
    func onReloadTableViewData()
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
    func onFetchFailed(with reason: String)
}

/*
 Description: Transform model information into values that can be displayed on the view. comforms to the CharactersViewModelProtocol protocol.
 property1: delegate
 property2: characters
 property3: currentPage
 property4: total
 property5: isFetchInProgress
 property6: searchQuery
 property7: endpoint
 method1: init
        parameter1: endpoint
        parameter2: delegate (CharactersViewModelDelegate)
 property7: totalCount
 property8: currentCount
 method2: character
        parameter1: index
 method3: deleteAllCharacters
 method4: fetchCharacters
 method5: searchCharacter
        parameter1: searchString
 method6: makeUrlRequest
        parameter1: url
 method7: calculateIndexPathsToReload
        parameter1:
 */

class CharactersViewModel: CharactersViewModelProtocol {
    private weak var delegate: CharactersViewModelDelegate?
    
    
    private var characters: [Result] = []
    private var currentPage = 0
    private var total = 0
    private var isFetchInProgress = false
    var searchQuery: String?
    
    let client = MarvelRestClient()
    let endPoint: Endpoint
    
    /*
     Description: sets the initial value for the stored property delegate and endpoint
     */
    
    init( endPoint: Endpoint, delegate: CharactersViewModelDelegate) {
        self.delegate = delegate
        self.endPoint = endPoint
    }
    
    /*
     Description: return the total number of elements in the character endpoint from the API
     */
    var totalCount: Int {
      return total
    }
    
    /*
     Description: return the current count of elements in the array of characters currently available
     */
    var currentCount: Int {
      return characters.count
    }
    
    /*
     Description: returns the character at the specidied index from the parameter
     */
    func character(at index: Int) -> Result {
      return characters[index]
    }
    
    /*
     Description: removes all the elements of the characters array, sets the value of total, currentPage to zero and call the delegate method onReloadTableViewData()
     */
    func deleteAllCharacters() {
        self.total = 0
        self.currentPage = 0
        self.characters.removeAll()
        self.delegate?.onReloadTableViewData()
    }
    
    /*
     Description: checks if there is already a fetch in progress before calling makeUrlRequest method to featch characters
     */
    func fetchCharacters() {
        
        guard !isFetchInProgress else {
            return
        }
        
        isFetchInProgress = true
        makeUrlRequest(url: endPoint.url)
    }
    
    /*
     Description: checks if there is already a fetch in progress before appendng the search query to the url and then calling makeUrlRequest method to featch characters
     */
    func searchCharacter(searchString: String) {
        guard !isFetchInProgress else {
            return
        }
        
        isFetchInProgress = true
        self.searchQuery = searchString
        
        guard let url = endPoint.url, let appendedUrl =  url.append(queryParameters: ["nameStartsWith": searchString]) else {
            self.delegate?.onFetchFailed(with: NetworkResponseError.url.reason)
            return
        }
        
        makeUrlRequest(url: appendedUrl)
    }
    
    /*
     Description: calls the fetchCharacters method from the MarvelRestClient instance.
     */
    private func makeUrlRequest(url: URL?) {
        client.fetchCharacters(with: url, page: currentPage) { result in
            switch result {
            
            case .failure(let error):
              DispatchQueue.main.async {
                self.isFetchInProgress = false
                self.delegate?.onFetchFailed(with: error.reason)
              }
            
            case .success(let response):
                
                DispatchQueue.main.async {
                    self.currentPage += 20
                    self.isFetchInProgress = false
                    self.total = response.data.total
                    self.characters.append(contentsOf: response.data.results)
                    
                    if response.data.offset > 20 {
                        let indexPathsToReload = self.calculateIndexPathsToReload(from: response.data.results)
                        self.delegate?.onFetchCompleted(with: indexPathsToReload)
                    } else {
                        self.delegate?.onFetchCompleted(with: .none)
                    }
                }
                
            }
        }
    }
    
    /*
     Description: alculates the index paths for the last page of characters received from the MarvelRestClient
     */
    private func calculateIndexPathsToReload(from newCharacters: [Result]) -> [IndexPath] {
      let startIndex = characters.count - newCharacters.count
      let endIndex = startIndex + newCharacters.count
      return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }

}
