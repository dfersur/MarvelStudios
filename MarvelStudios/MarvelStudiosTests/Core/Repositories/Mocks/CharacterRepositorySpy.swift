//
//  File.swift
//  MarvelStudiosTests
//
//  Created by David Manuel Fernández Suárez on 13/6/22.
//  Copyright © 2022 MynSoftware. All rights reserved.
//

@testable import MarvelStudios
import Foundation

class CharacterRepositorySpy: CharacterRepository {
    
    var failure: Bool = false
    
    func prepareForSuccess() -> CharacterRepositorySpy {
        failure = false
        return self
    }
    
    func prepareForFailure() -> CharacterRepositorySpy {
        failure = true
        return self
    }
    
    func getCharacters() async throws -> [MarvelStudios.Character] {
        if failure {
            throw CustomRequestBuilderError.noData
        } else {
            return [
                getMockCharacter(id: 0, name: "prueba0"),
                getMockCharacter(id: 1, name: "prueba1"),
            ]
        }
    }
    
    func getCharacter(by id: Int) async throws -> MarvelStudios.Character? {
        if failure {
            throw CustomRequestBuilderError.noData
        } else {
            return getMockCharacter(id: 0, name: "prueba0")
        }
    }
    
    private func getMockCharacter(id: Int, name: String) -> MarvelStudios.Character {
        return MarvelStudios.Character(id: id, name: name, description: nil, modefied: nil, resourceURI: "", series: nil, thumbnail: nil)
    }
    
    
}
