//
//  Rick_MortyApp.swift
//  Rick&Morty
//
//  Created by Константин Шмондрик on 07.01.2023.
//

import SwiftUI
import Combine


@main
struct Rick_MortyApp: App {
   
    var body: some Scene {
        WindowGroup {
            
            var subscriptions = Set<AnyCancellable>()
            let filter = Filter()
            let viewModel = CharactersViewModel()
            
//            filter.$tags
//                .assign(to: \.filterTags, on: viewModel)
//                .store(in: &subscriptions)

            CharactersView(viewModel: viewModel)
                .environmentObject(filter)
            
        }
    }
}

