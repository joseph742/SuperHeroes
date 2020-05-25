//
//  NetworkResponseError.swift
//  SuperHeroes
//
//  Created by Joseph Umoru on 14/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import Foundation

/*
 Description: Enumerates the states of a network response error
 */

enum NetworkResponseError: Error {
    case network
    case decoding
    case url
    case rateLimit
    
    var reason: String {
      switch self {
      case .network:
        return "An error occurred while fetching data"
      case .decoding:
        return "An error occurred while decoding data"
      case .url:
        return "An invalid url was supplied"
      case .rateLimit:
        return "You have exceeded the daily rate limit of 3000 requests please try agian tomorrow"
      }
    }
}
