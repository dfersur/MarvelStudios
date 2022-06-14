//
//  Constants.swift
//  MarvelStudios
//
//  Created by David Manuel Fernández Suárez on 10/6/22.
//

import Foundation

/// Builder de la api de Marvel
class MarvelPointBuilder {
    
    private let basePath: String = "https://gateway.marvel.com/v1/public/"
    private var endpoint: String
    private var id: Int?
    private var limit: Int = 5
    
    private let publicAPIKey: String = "<<publicKey>>"
    private let privateAPIKey: String = "<<privateKey>>"
    
    init(endpoint: String) {
        self.endpoint = endpoint
    }
    
    /// Define el id de la característica
    /// - Parameter id: Id seleccionado
    /// - Returns: Objeto instanciado del constructor
    func set(id: Int) -> MarvelPointBuilder {
        self.id = id
        return self
    }
    
    /// Define el límite de los elementos
    /// - Parameter limit: Número de elementos a mostrar.
    /// - Returns: Objeto instanciado del constructor
    func set(limit: Int) -> MarvelPointBuilder {
        self.limit = limit
        return self
    }
    
    /// Constructor
    /// - Returns: Cadena de texto con la url construida para la API.
    func build() -> String? {
        let ts = String (Date () . timeIntervalSince1970)
        guard let hash = "\(ts)\(privateAPIKey)\(publicAPIKey)".md5() else {
            return nil
        }
        return String(format: "%@%@?limit=%d&ts=%@&apikey=%@&hash=%@", basePath, getEndPoint(),limit, ts, publicAPIKey, hash)
    }
    
    private func getEndPoint() -> String {
        var formatEndpoint = endpoint
        if let id = id {
            formatEndpoint = "\(formatEndpoint)/\(id)"
        }
        return formatEndpoint
    }
    
}
