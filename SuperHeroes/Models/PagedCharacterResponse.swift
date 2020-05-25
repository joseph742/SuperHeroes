//
//  PagedCharacterResponse.swift
//  SuperHeroes
//
//  Created by Joseph Umoru on 14/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import Foundation

/*
 Description: A wrapper for the PagedCharacterResponse data from the MarvelRestClient
 property1: code
 property2: status
 property3: copyright
 property4: attributionText
 property5: attributionHTML
 property6: etag
 property7: data
 */

struct PagedCharacterResponse: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: DataClass
}
