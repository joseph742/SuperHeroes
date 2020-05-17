//
//  URL+Extension.swift
//  SuperHeroes
//
//  Created by Qasim Ahmed on 17/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import Foundation

extension URL {
    func append(queryParameters: [String: String]) -> URL? {
        guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            return nil
        }
        
        let urlQueryItems = queryParameters.map{
            return URLQueryItem(name: $0, value: $1)
        }
        urlComponents.queryItems?.append(contentsOf: urlQueryItems)
        return urlComponents.url
    }
}
