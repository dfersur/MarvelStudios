//
//  ListMocks.swift
//  MarvelStudiosTests
//
//  Created by David Manuel Fernández Suárez on 14/6/22.
//  Copyright © 2022 MynSoftware. All rights reserved.
//

@testable import MarvelStudios

import Foundation

class ListMocks {
    
    static func getList() -> [List.CharacterViewModel] {
        return [
            List.CharacterViewModel(id: 0, name: "prueba0"),
            List.CharacterViewModel(id: 1, name: "prueba1")
        ]
    }

}
