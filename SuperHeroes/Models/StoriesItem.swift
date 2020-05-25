//
//  StoriesItem.swift
//  SuperHeroes
//
//  Created by Joseph Umoru on 14/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import Foundation

/*
 Description: A wrapper for the StoriesItem data from the MarvelRestClient
 property1: resourceURI
 property2: name
 property3: type
 */

struct StoriesItem: Codable {
    let resourceURI: String
    let name: String
    let type: String
}
