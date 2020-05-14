//
//  DataClass.swift
//  SuperHeroes
//
//  Created by Joseph Umoru on 14/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import Foundation

struct DataClass: Codable {
    let offset, limit, total, count: Int
    let results: [Result]
}
