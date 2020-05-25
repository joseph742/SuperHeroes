//
//  Stories.swift
//  SuperHeroes
//
//  Created by Joseph Umoru on 14/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import Foundation

/*
 Description: A wrapper for the Stories data from the MarvelRestClient
 property1: available
 property2: collectionURI
 property3: items
 property4: returned
 */

struct Stories: Codable {
    let available: Int
    let collectionURI: String
    let items: [StoriesItem]
    let returned: Int
}
