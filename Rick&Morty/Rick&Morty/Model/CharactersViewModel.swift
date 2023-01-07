//
//  CharactersViewModel.swift
//  Rick&Morty
//
//  Created by Константин Шмондрик on 07.01.2023.
//

import Foundation

class CharactersViewModel {
    
    private var allCaracters: [Character] = []
    var error: APIClient.Error? = nil
    var lustUpdateTime: TimeInterval = Date().timeIntervalSince1970
    
    private var apiClient = APIClient()
    private var currentPage: Int = 1
    
    var filterTags: [Tag] = []
    var characters: [Character] {
        guard !filterTags.isEmpty else {
            return allCaracters
        }
        
        return allCaracters
            .filter { (character) -> Bool in
                return filterTags.reduce(false) { (isMatch, tag) -> Bool in
                    self.checkMatching(character: character, for: tag)
                }
            }
    }
    
    private func checkMatching(character: Character, for tag: Tag) -> Bool {
        switch tag {
        case .alive, .dead:
            return character.status.lowercased() == tag.rawValue.lowercased()
        case .female, .male, .genderless:
            return character.gender.lowercased() == tag.rawValue.lowercased()
        }
    }
    
}
