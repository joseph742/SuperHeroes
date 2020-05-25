//
//  Result.swift
//  SuperHeroes
//
//  Created by Joseph Umoru on 14/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import Foundation

/*
 Description: A wrapper for the Result data from the MarvelRestClient
 property1: id
 property2: name
 property3: resultDescription
 property4: modified
 property5: thumbnail
 property6: resourceURI
 property7: comics
 property8: series
 property9: stories
 property10: events
 property11: urls
 property11: CodingKeys
 */

struct Result: Codable {
    let id: Int
    let name, resultDescription: String
    let modified: Date
    let thumbnail: Thumbnail
    let resourceURI: String
    let comics, series: Comics
    let stories: Stories
    let events: Comics
    let urls: [URLElement]

    enum CodingKeys: String, CodingKey {
        case id, name
        case resultDescription = "description"
        case modified, thumbnail, resourceURI, comics, series, stories, events , urls
    }
}
