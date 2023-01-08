//
//  Filter.swift
//  Rick&Morty
//
//  Created by Константин Шмондрик on 07.01.2023.
//

import Foundation
import Combine


enum Tag: String, CaseIterable, Identifiable {
    case alive
    case dead
    case male
    case female
    case genderless
    
    var id: String {
        return self.rawValue
    }
}

final class Filter: ObservableObject {
    
   @Published var tags: [Tag] = []
    
    init() {}
}
