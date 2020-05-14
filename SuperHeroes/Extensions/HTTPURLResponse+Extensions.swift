//
//  HTTPURLResponse+Extensions.swift
//  SuperHeroes
//
//  Created by Joseph Umoru on 14/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import Foundation

extension HTTPURLResponse {
    var hasSuccessStatusCode: Bool {
        return 200...299 ~= statusCode
    }
    
    var hasReachedRateLimit: Bool {
        return 429 ~= statusCode
    }
    
}
