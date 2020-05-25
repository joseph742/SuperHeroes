//
//  DataClass.swift
//  SuperHeroes
//
//  Created by Joseph Umoru on 14/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import Foundation

/*
 Description: A wrapper for the DataClass data from the MarvelRestClient
 property1: offset
 property2: limit
 property3: total
 property4: count
 property5: results
 */

struct DataClass: Codable {
    let offset, limit, total, count: Int
    let results: [Result]
}
