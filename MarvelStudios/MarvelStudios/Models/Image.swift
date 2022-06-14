//
//  Image.swift
//  MarvelStudios
//
//  Created by David Manuel Fernández Suárez on 12/6/22.
//  Copyright © 2022 MynSoftware. All rights reserved.
//

import Foundation

struct Image: Decodable {
    let path: String?
    let ext: String?
    
    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
}
