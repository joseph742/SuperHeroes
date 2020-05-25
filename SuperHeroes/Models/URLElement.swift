//
//  URLElement.swift
//  SuperHeroes
//
//  Created by Joseph Umoru on 14/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import Foundation

/*
 Description: A wrapper for the URLElement data from the MarvelRestClient
 property1: type
 property2 url
 */

struct URLElement: Codable {
    let type: String
    let url: String
}
