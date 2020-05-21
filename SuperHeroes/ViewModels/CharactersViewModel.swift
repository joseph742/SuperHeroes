//
//  CharactersViewModel.swift
//  SuperHeroes
//
//  Created by Joseph Umoru on 14/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import Foundation

protocol CharactersViewModelDelegate: class {
    func onReloadTableViewData()
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
    func onFetchFailed(with reason: String)
}


class CharactersViewModel: CharactersViewModelProtocol {
    private weak var delegate: CharactersViewModelDelegate?
    
    
    private var characters: [Result] = []
    private var currentPage = 0
    private var total = 0
    private var isFetchInProgress = false
    var searchQuery: String?
    
    let client = MarvelRestClient()
    let endPoint: Endpoint
    
    init( endPoint: Endpoint, delegate: CharactersViewModelDelegate) {
        self.delegate = delegate
        self.endPoint = endPoint
    }
    
    var totalCount: Int {
      return total
    }
    
    var currentCount: Int {
      return characters.count
    }
    
    func character(at index: Int) -> Result {
      return characters[index]
    }
    
    func deleteAllCharacters() {
        self.total = 0
        self.currentPage = 0
        self.characters.removeAll()
        self.delegate?.onReloadTableViewData()
    }
    
    func fetchCharacters() {
        
        guard !isFetchInProgress else {
            return
        }
        
        isFetchInProgress = true
        makeUrlRequest(url: endPoint.url)
    }
    
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
    
    private func calculateIndexPathsToReload(from newPhotos: [Result]) -> [IndexPath] {
      let startIndex = characters.count - newPhotos.count
      let endIndex = startIndex + newPhotos.count
      return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }

}
