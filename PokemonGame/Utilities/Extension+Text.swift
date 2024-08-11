//
//  Extension+Text.swift
//  PokemonGame
//
//  Created by Fandrian Rhamadiansyah on 09/08/24.
//

import SwiftUI

extension Text {
    func pokeWhiteText(_ font: Font, borderWidth: CGFloat = 1) -> some View {
        self.foregroundColor(.black)
            .fontWeight(.semibold)
            .font(font)
            .frame(maxWidth: .infinity)
            .padding(10)
            .background(content: {
                RoundedRectangle(cornerRadius: 5)
                    .fill(.white)
            })
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.black, lineWidth: borderWidth)
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
    }
}


