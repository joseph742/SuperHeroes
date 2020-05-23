//
//  CharacterDescriptionViewControllerViewModelProtocol.swift
//  SuperHeroes
//
//  Created by Qasim Ahmed on 23/05/2020.
//  Copyright © 2020 teckdk. All rights reserved.
//

import Foundation

protocol CharacterDescriptionViewControllerViewModelProtocol {
    var characterName: String { get }
    var characterDescription: String { get }
    var characterImageUrl: URL? { get }
    func processData()
}
