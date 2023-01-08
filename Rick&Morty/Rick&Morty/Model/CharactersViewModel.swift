//
//  CharactersViewModel.swift
//  Rick&Morty
//
//  Created by Константин Шмондрик on 07.01.2023.
//

import Foundation
import Combine

class CharactersViewModel: ObservableObject {
    
    @Published private var allCaracters: [Character] = []
    @Published var error: APIClient.Error? = nil
    @Published var lustUpdateTime: TimeInterval = Date().timeIntervalSince1970
    @Published var filterTags: [Tag] = []
    
    private var apiClient = APIClient()
    private var currentPage: Int = 1
    
    var cancellable = Set<AnyCancellable>()
    
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
    
    func fetchCharacters() {
        apiClient
            .page(num: currentPage + 1)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error
                }
            }, receiveValue: { [weak self] page in
                self?.error = nil
                self?.allCaracters.append(contentsOf: page.results)
                self?.currentPage += 1
                self?.lustUpdateTime = Date().timeIntervalSince1970
            })
            .store(in: &cancellable)
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
