//
//  EndPoint.swift
//  SuperHeroes
//
//  Created by Joseph Umoru on 14/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import Foundation
import Keys

/*
 Description: Hold a path, URLQueryItem array and an url
 property1: path
 property2: URLQueryItem
 property3: url (optional)
 */

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "gateway.marvel.com"
        components.port = 443
        components.path = path
        components.queryItems = queryItems

        return components.url
    }
}

/*
 Description: Returns an instance of Endpoint with all properties initialized
 */

extension Endpoint {
    static func getRequest(sortedBy sorting: Sorting = .nameAscending) -> Endpoint {
        let keys = SuperHeroesKeys()
        let ts = String(Date().timeIntervalSince1970)
        let stringToHash = ts + keys.privateKey + keys.publicKey
        let md5Data = stringToHash.md5
        
        return Endpoint(
            path: "/v1/public/characters",
            queryItems: [
                URLQueryItem(name: "limit", value: PaginationLimit.limit),
                URLQueryItem(name: "apikey", value: keys.publicKey),
                URLQueryItem(name: "hash", value: md5Data),
                URLQueryItem(name: "ts", value: ts),
                URLQueryItem(name: "orderBy", value: sorting.rawValue)
            ]
        )
    }
}
