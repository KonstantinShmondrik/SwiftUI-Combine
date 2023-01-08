//
//  CharacterCell.swift
//  Rick&Morty
//
//  Created by Константин Шмондрик on 07.01.2023.
//

import SwiftUI
import Kingfisher

struct CharacterView: View {
    
    var character: Character
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .firstTextBaseline) {
                Text(character.name)
                    .multilineTextAlignment(.leading)
                Spacer()
                Button("More") {
                    
                }
                .font(.callout)
            }
            .font(.title)
            KFImage(URL(string: character.image))
                .resizable()
                .aspectRatio(contentMode: .fill)
            Text("Gender: " + character.gender)
            Text("Status: " + character.status)
            if character.type.isEmpty == false {
                Text("Type: " + character.type)
            }
        }
        .padding()
    }
}
