//
//  CharacterDTO.swift
//  Yassir_Character
//
//  Created by Ibrahim Mostafa on 01/06/2024.
//

import Foundation

struct Info: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

struct Location: Decodable {
    let name: String
    let url: String
}

struct Character: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let location: Location
    let image: String
    let url: String
}

struct CharacterDTO: Decodable {
    let info: Info
    var results: [Character]
}
