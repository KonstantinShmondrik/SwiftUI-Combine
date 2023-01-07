//
//  Rick_MortyApp.swift
//  Rick&Morty
//
//  Created by Константин Шмондрик on 07.01.2023.
//

import SwiftUI

@main
struct Rick_MortyApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = CharactersViewModel()
            CharactersView(model: viewModel)
        }
    }
}
