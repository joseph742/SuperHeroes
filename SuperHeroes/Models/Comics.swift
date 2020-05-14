//
//  Comics.swift
//  SuperHeroes
//
//  Created by Joseph Umoru on 14/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import Foundation

struct Comics: Codable {
    let available: Int
    let collectionURI: String
    let items: [ComicsItem]
    let returned: Int
}
