//
//  Strings + Additions.swift
//  MarvelStudios
//
//  Created by David Manuel Fernández Suárez on 11/6/22.
//

import Foundation
import CryptoKit

extension String {
    
    /// Algoritmo hash md5
    /// - Returns: Cadena de texto con el hash
    func md5() -> String? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        return Insecure.MD5.hash(data: data).map {
            String(format: "%02hhx", $0)
        }.joined()
    }
    
}
