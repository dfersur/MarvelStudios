//
//  Character.swift
//  MarvelStudios
//
//  Created by David Manuel Fernández Suárez on 12/6/22.
//  Copyright © 2022 MynSoftware. All rights reserved.
//

import Foundation

struct Character: Decodable {
    let id: Int?
    let name: String?
    let description: String?
    let modefied: Date?
    let resourceURI: String?
    let series: SerieList?
    let thumbnail: Image?
}
