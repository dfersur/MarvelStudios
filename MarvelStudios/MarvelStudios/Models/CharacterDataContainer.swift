//
//  CharacterDataContainer.swift
//  MarvelStudios
//
//  Created by David Manuel Fernández Suárez on 12/6/22.
//  Copyright © 2022 MynSoftware. All rights reserved.
//

import Foundation

struct CharacterDataContainer: Decodable {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [Character]
}
