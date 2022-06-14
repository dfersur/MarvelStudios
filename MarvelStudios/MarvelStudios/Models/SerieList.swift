//
//  SerieList.swift
//  MarvelStudios
//
//  Created by David Manuel Fernández Suárez on 12/6/22.
//  Copyright © 2022 MynSoftware. All rights reserved.
//

import Foundation

struct SerieList: Decodable {
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [SeriesSummary]
}
