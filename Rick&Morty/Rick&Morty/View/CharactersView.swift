//
//  ContentView.swift
//  Rick&Morty
//
//  Created by Константин Шмондрик on 07.01.2023.
//

import SwiftUI
import Kingfisher

struct CharactersView: View {
    var model: CharactersViewModel
    var filterSettingsIsPresented: Bool = false
    var currentDate: Date = Date()
    
    init(model: CharactersViewModel) {
        self.model = model
    }
    
    
    var body: some View {
        let filter: String = "All characters"
        
        return NavigationView {
            List {
                Section(header: SectionHeaderView(header: filter, lastUpdateTime: model.lustUpdateTime, currentDate: self.currentDate)) {
                    ForEach(self.model.characters) { character in
                        CharacterView(character: character)
                    }
                    // 4. Добавляем таймер
                }
                .padding(2)
            }
            // 2. Добавляем отображение меню настроек
            // 3. Отображаем ошибки
            .navigationBarTitle(Text("Characters"))
            .navigationBarItems(trailing:
                                    Button("Filter") {
                // 1. Устанавливаем filterSettingsIsPresented
            }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView(model: CharactersViewModel())
    }
}
