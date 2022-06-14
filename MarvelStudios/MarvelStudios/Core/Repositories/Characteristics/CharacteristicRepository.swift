//
//  CharacterRepository.swift
//  MarvelStudios
//
//  Created by David Manuel Fernández Suárez on 11/6/22.
//

import Foundation

protocol CharacterRepository {
    func getCharacters() async throws -> [Character]
    func getCharacter(by id: Int) async throws -> Character?
}
