//
//  CharacterNetworkService.swift
//  Yassir_Character
//
//  Created by Ibrahim Mostafa on 01/06/2024.
//

import Foundation

struct CharacterNetworkService {
    
    static func getCharacters(with status:String? = nil) async -> CharacterDTO? {
        let url = HTTPRequest.EndPoint.getCharacters(withStatus: status).url
        return await getCharacters(with: url)

    }
    static func getCharacters(fromNextURLString: String) async -> CharacterDTO? {
        guard let url = URL(string: fromNextURLString) else { return nil }
        return await getCharacters(with: url)
    }
    
    static private func getCharacters(with url:URL) async -> CharacterDTO? {
        do {
            let data = try await HTTPRequest.request(url: url, httpMethod: .get)

            return  HTTPRequest.decode(type: CharacterDTO.self, data: data)
        } catch {
            return nil
        }

    }
}
