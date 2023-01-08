//
//  ContentView.swift
//  Rick&Morty
//
//  Created by Константин Шмондрик on 07.01.2023.
//

import SwiftUI
import Kingfisher
import Combine

struct CharactersView: View {
    
    @State private var filterSettingsIsPresented: Bool = false
    @State var currentDate: Date = Date()
    @ObservedObject var viewModel: CharactersViewModel
   
    @EnvironmentObject var filter: Filter
//    @StateObject var filter: Filter = Filter()
   
   private var timer = Timer.publish(every: 5, on: .main, in: .common)
        .autoconnect()
        .eraseToAnyPublisher()
    
    init(viewModel: CharactersViewModel) {
        self.viewModel = viewModel
    }
    
    
    var body: some View {
        let filter: String = "All characters"
        
        return NavigationView {
            List {
                Section(header: SectionHeaderView(header: filter, lastUpdateTime: viewModel.lustUpdateTime, currentDate: self.currentDate)) {
                    ForEach(self.viewModel.characters) { character in
                        CharacterView(character: character)
                    }
                    // 4. Добавляем таймер
                    .onReceive(timer) {
                        self.currentDate = $0
                    }
                }
                .padding(2)
            }
            // 2. Добавляем отображение меню настроек
            .sheet(isPresented: $filterSettingsIsPresented) {
                FilterSettingsView()
                    .environmentObject(self.filter)
            }
            // 3. Отображаем ошибки
            .alert(item: $viewModel.error) { error in
                Alert(title: Text("Network Error"),
                      message: Text(error.localizedDescription),
                      dismissButton: .cancel())
            }
            .navigationBarTitle(Text("Characters"))
            .navigationBarItems(trailing:
                                    Button("Filter") {
                // 1. Устанавливаем filterSettingsIsPresented
                filterSettingsIsPresented.toggle()
            }
                .foregroundColor(.blue)
            )
        }
        .onAppear() {
            viewModel.fetchCharacters()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView(viewModel: CharactersViewModel())
    }
}
