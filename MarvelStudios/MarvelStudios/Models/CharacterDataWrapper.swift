//
//  Character.swift
//  MarvelStudios
//
//  Created by David Manuel Fernández Suárez on 11/6/22.
//

import Foundation

struct CharacterDataWrapper: Decodable {
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let data: CharacterDataContainer?
    let etag: String?
}
