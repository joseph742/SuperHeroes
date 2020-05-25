//
//  ComicsItem.swift
//  SuperHeroes
//
//  Created by Joseph Umoru on 14/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import Foundation

/*
 Description: A wrapper for the ComicsItem data from the MarvelRestClient
 property1: resourceURI
 property2: name
 */

struct ComicsItem: Codable {
    let resourceURI: String
    let name: String
}
