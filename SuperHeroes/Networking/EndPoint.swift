//
//  EndPoint.swift
//  SuperHeroes
//
//  Created by Joseph Umoru on 14/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import Foundation

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
}

extension Endpoint {
    static func getRequest(pageNumber: Int, sortedBy sorting: Sorting = .nameAscending) -> Endpoint {
        let ts = String(Date().timeIntervalSince1970)
        let stringToHash = ts + ApiConstant.privateKey + ApiConstant.publicKey;
        let md5Data = stringToHash.md5
        return Endpoint(
            path: "/v1/public/characters",
            queryItems: [
                URLQueryItem(name: "limit", value: ApiConstant.limit),
                URLQueryItem(name: "offset", value: "\(pageNumber)"),
                URLQueryItem(name: "apikey", value: ApiConstant.publicKey),
                URLQueryItem(name: "hash", value: md5Data),
                URLQueryItem(name: "ts", value: ts),
                URLQueryItem(name: "orderBy", value: sorting.rawValue)
            ]
        )
    }
    
    static func getSearchRequest(pageNumber: Int, matching query: String, sortedBy sorting: Sorting = .nameAscending) -> Endpoint {
        let ts = String(Date().timeIntervalSince1970)
        let stringToHash = ts + ApiConstant.privateKey + ApiConstant.publicKey;
        let md5Data = stringToHash.md5
        return Endpoint(
            path: "/v1/public/characters",
            queryItems: [
                URLQueryItem(name: "limit", value: ApiConstant.limit),
                URLQueryItem(name: "offset", value: "\(pageNumber)"),
                URLQueryItem(name: "apikey", value: ApiConstant.publicKey),
                URLQueryItem(name: "hash", value: md5Data),
                URLQueryItem(name: "ts", value: ts),
                URLQueryItem(name: "orderBy", value: sorting.rawValue),
                URLQueryItem(name: "nameStartsWith", value: query)
            ]
        )
    }
}

extension Endpoint {
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
