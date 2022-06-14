//
//  CustomRequestBuilder.swift
//  MarvelStudios
//
//  Created by David Manuel Fernández Suárez on 10/6/22.
//

import Foundation

enum Method: String {
    case GET, POST, PUT, DELETE
}

enum CustomRequestBuilderError: Error {
    case unknowError
    case urlError
    case encodeError
    case decodeError
    case noData
    case serverControlledError(description: String?)
}

/// Builder que construye la petición nativa
class CustomRequestBuilder<T: Decodable> {
    
    private var baseUrl: String = ""
    private var url: String?
    private var timeOut: Double = 120
    private var body: Data?
    private var method: Method = .GET
    private var params: [String: String] = [:]
    
    private var errorDecodable: Bool = false
    
    /// Define la base de la url del servicio
    /// - Parameter baseUrl: Cadena de texto de la base del servicio
    /// - Returns: Instancia del builder
    func set(baseUrl: String) -> CustomRequestBuilder {
        self.baseUrl = baseUrl
        return self
    }
    
    /// Define el endPoint o la url del servicio
    /// - Parameter url: Endpoint o urle del servicio
    /// - Returns: Instancia del builder
    func set(url: String) -> CustomRequestBuilder {
        self.url = url
        return self
    }
    
    /// Define el tiempo de espera
    /// - Parameter timeOut: Tiempo de espera
    /// - Returns: Instancia del builder
    func set(timeOut: Double) -> CustomRequestBuilder {
        self.timeOut = timeOut
        return self
    }
    
    /// Define a la petición el verbo para la llamada
    /// - Parameter method: Tipo de método para hacer la petición (GET, POST, PUT, DELETE)
    /// - Returns: Instancia del builder con el método
    func set(method: Method) -> CustomRequestBuilder {
        self.method = method
        return self
    }
    
    /// Añade un parámetro a la petición
    /// - Parameters:
    ///   - param: Parámetro
    ///   - value: Valor del parámetro
    ///   - Returns: Instancia del builder con el método
    func set(param: String, value: String) -> CustomRequestBuilder {
        self.params[param] = value
        return self
    }
    
    /// Añade a la petición los parámetros de entrada
    /// - Returns: Instancia del builder con los parámetros
    func set<S: Encodable>(body: S) -> CustomRequestBuilder {
        do {
            self.body = try JSONEncoder().encode(body)
        } catch {
            errorDecodable = true
            self.body = nil
        }
        return self
    }
    
    /// Método que realiza la petición
    func execute() async throws -> T{
        
        guard let url = url, let serverURL = URL(string: String(format: "%@%@", baseUrl, url)) else {
            throw CustomRequestBuilderError.urlError
        }
        
        guard !errorDecodable else {
            throw CustomRequestBuilderError.decodeError
        }
                
        let (data, response) = try await URLSession.shared.data(for: getRequest(serverURL: serverURL))
        
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200, httpResponse.statusCode < 300 {
            do {
                let objectDecoded = try JSONDecoder().decode(T.self, from: data)
                return objectDecoded
            } catch {
                throw CustomRequestBuilderError.decodeError
            }
        } else {
            throw CustomRequestBuilderError.unknowError
        }
    }
    
    /// Construye la petición
    /// - Parameter serverURL: Objeto URL de la petición
    /// - Returns: La petición del tipo URLRequest
    private func getRequest(serverURL: URL) -> URLRequest {
        var request: URLRequest = URLRequest(url: serverURL)
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = timeOut
        request.httpMethod = method.rawValue
        
        params.forEach { (key, value) in
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        if let body = body {
            request.httpBody = body
        }
        
        return request
    }
    
}
