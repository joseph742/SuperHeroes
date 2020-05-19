//
//  PagedCharacterResponse+Extension.swift
//  SuperHeroesTests
//
//  Created by Qasim Ahmed on 19/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import Foundation
@testable import SuperHeroes

extension PagedCharacterResponse: Stubbable {
    static func stub() -> PagedCharacterResponse {
        let comicItem = ComicsItem(resourceURI: "http://gateway.marvel.com/v1/public/comics/21366", name: "Avengers: The Initiative (2007) #14")
        let storyItem = StoriesItem(resourceURI: "http://gateway.marvel.com/v1/public/stories/19947", name: "Cover #19947", type: "cover")
        let urlElements = URLElement(type: "detail", url: "http://marvel.com/comics/characters/1011334/3-d_man?utm_campaign=apiRef&utm_source=bd0a31c75c39fef2199261fbf187fe5d")
        let thumbnail = Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", thumbnailExtension: "jpg")
        
        let comic = Comics(available: 12, collectionURI: "http://gateway.marvel.com/v1/public/characters/1011334/comics", items: [comicItem], returned: 1)
        let stories = Stories(available: 21, collectionURI: "http://gateway.marvel.com/v1/public/characters/1011334/stories", items: [storyItem], returned: 1)
        let resultData = Result(id: 1011334, name: "3-D Man", resultDescription: "", modified: Date(), thumbnail: thumbnail, resourceURI: "http://gateway.marvel.com/v1/public/characters/1011334", comics: comic, series: comic, stories: stories, events: comic, urls: [urlElements])
        let dataClass = DataClass(offset: 0, limit: 1, total: 1493, count: 1, results: [resultData])
        
        let pagedResponse = PagedCharacterResponse(code: 200, status: "Ok", copyright: "© 2020 MARVEL", attributionText: "Data provided by Marvel. © 2020 MARVEL", attributionHTML: "<a href=\"http://marvel.com\">Data provided by Marvel. © 2020 MARVEL</a>", etag: "4eaacae2701b1b2dc665917af2ddf46f7e2ba192", data: dataClass)
        
        return pagedResponse
    }
}
