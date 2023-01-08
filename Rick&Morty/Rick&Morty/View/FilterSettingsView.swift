//
//  FilterSettingsView.swift
//  Rick&Morty
//
//  Created by Константин Шмондрик on 07.01.2023.
//

import SwiftUI

struct FilterSettingsView: View {
    
//    @State private var tags: [Tag] = []
    @EnvironmentObject var filter: Filter
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Tag.allCases) { tag in
                    Button(action: {
                        self.changeTagState(tag)
                    }, label: {
                        HStack {
                            if self.filter.tags.contains(tag) {
                                Image(systemName: "checkmark.circle.fill")
                            }
                            Text(tag.rawValue.capitalized)
                        }
                    })
                }
            }
            .navigationBarTitle(Text("Tags"))
            .navigationBarItems(trailing:
                                    Button("Done") {
            }
            )
        }
    }
    
    func changeTagState(_ tag: Tag) {
        filter.tags.contains(tag)
        ? filter.tags.removeAll(where: { $0 == tag })
        : filter.tags.append(tag)
    }
}
