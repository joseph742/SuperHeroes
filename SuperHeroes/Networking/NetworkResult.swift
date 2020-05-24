//
//  NetworkResult.swift
//  SuperHeroes
//
//  Created by Joseph Umoru on 14/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import Foundation

/*
 Description: eumerates the state of a network response either success or failure
 */
enum NetworkResult<T, U: Error> {
  case success(T)
  case failure(U)
}
