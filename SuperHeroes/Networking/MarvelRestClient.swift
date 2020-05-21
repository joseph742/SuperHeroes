//
//  MarvelRestClient.swift
//  SuperHeroes
//
//  Created by Joseph Umoru on 14/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import Foundation

class MarvelRestClient: MarvelRestClientProtocol {
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
      self.session = session
    }
    
    func fetchCharacters(with url: URL?, page: Int, completion: @escaping (NetworkResult<PagedCharacterResponse, NetworkResponseError>) -> ()) {
        
        
        guard let endpointUrl = url, let appendedUrl = endpointUrl.append(queryParameters: ["offset": "\(page)"]) else {
            return completion(NetworkResult.failure(NetworkResponseError.url))
        }
        let requestUrl = URLRequest(url: appendedUrl)
        
        session.dataTask(with: requestUrl, completionHandler: { data, response, error in
            if let httpResponse = response as? HTTPURLResponse, httpResponse.hasSuccessStatusCode, let data = data {
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                guard let decodedResponse = try? decoder.decode(PagedCharacterResponse.self, from: data) else {
                    completion(NetworkResult.failure(NetworkResponseError.decoding))
                    return
                }
                
                completion(NetworkResult.success(decodedResponse))

            } else {
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 429 {
                    completion(NetworkResult.failure(NetworkResponseError.rateLimit))
                    return
                }
                
                completion(NetworkResult.failure(NetworkResponseError.network))
                return
            }
        }).resume()
    }
}
