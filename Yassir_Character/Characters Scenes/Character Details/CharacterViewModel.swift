//
//  CharacterViewModel.swift
//  Yassir_Character
//
//  Created by Ibrahim Mostafa on 02/06/2024.
//

import Foundation

struct CharacterViewModel {
    let name: String
    let species: String
    let status: String
    let gender: String
    let locationName: String
    let imageString: String
    var imageURL: URL? {
        URL(string: imageString)
    }
}
