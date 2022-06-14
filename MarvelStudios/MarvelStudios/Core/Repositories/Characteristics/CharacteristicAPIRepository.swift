//
//  CharacterAPIRepository.swift
//  MarvelStudios
//
//  Created by David Manuel Fernández Suárez on 11/6/22.
//

import Foundation

struct CharacterAPIRepository: CharacterRepository {
    
    func getCharacters() async throws -> [Character] {
        guard let urlCharacters = MarvelPointBuilder(endpoint: "characters")
            .set(limit: 100)
            .build() else {
            
            throw CustomRequestBuilderError.urlError
        }
        
        return try await CustomRequestBuilder<CharacterDataWrapper>()
                        .set(url: urlCharacters)
                        .execute().data?.results ?? []
    }
    
    func getCharacter(by id: Int) async throws -> Character? {
        guard let urlCharacters = MarvelPointBuilder(endpoint: "characters")
            .set(id: id)
            .build() else {
            
            throw CustomRequestBuilderError.urlError
        }
        
        return try await CustomRequestBuilder<CharacterDataWrapper>()
                        .set(url: urlCharacters)
                        .execute().data?.results.first(where: {$0.id == id})
    }
    
}
