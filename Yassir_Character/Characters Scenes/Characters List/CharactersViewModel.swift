//
//  CharactersViewModel.swift
//  Yassir_Character
//
//  Created by Ibrahim Mostafa on 01/06/2024.
//

import Foundation

class CharactersViewModel:ObservableObject {
    @Published private(set) var characters: [CharacterViewModel] = []
    private var isLoading = false
    
    private var charactersDTO: CharacterDTO? {
        didSet {
            characters = charactersDTO?.results.map {
                CharacterViewModel(name: $0.name, species: $0.species,status: $0.status, gender: $0.gender, locationName: $0.location.name, imageString: $0.image)
            } ?? []
        }
    }
    
    func getCharacters() async {
        charactersDTO = await CharacterNetworkService.getCharacters()
    }
    
    var rowsCount: Int {
        characters.count
    }
    
    func getCharacterViewModel(for index: Int) -> CharacterViewModel {
        characters[index]
    }

    func loadNextPage() async {
        guard isLoading == false else{ return }
        guard let nextUrlString = charactersDTO?.info.next else { return }
        
        isLoading = true

        let currentCharacters = charactersDTO?.results ?? []
        charactersDTO = await CharacterNetworkService.getCharacters(fromNextURLString: nextUrlString)
        let newCharacters = charactersDTO?.results ?? []
        charactersDTO?.results = currentCharacters + newCharacters
        isLoading = false
    }
    
    func filterCharacters(by status: StatusFilter) {
        let statusString = status == .none ? nil : status.rawValue
        Task {
            charactersDTO = await CharacterNetworkService.getCharacters(with: statusString)
        }
    }


}


enum StatusFilter: String{
    case alive
    case dead
    case unknown
    case none
}
