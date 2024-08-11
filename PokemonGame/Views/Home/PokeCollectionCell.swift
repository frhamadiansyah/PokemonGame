//
//  PokeCollectionCell.swift
//  PokemonGame
//
//  Created by Fandrian Rhamadiansyah on 09/08/24.
//

import SwiftUI

struct PokeCollectionCell: View {
    let poke: Pokemon
    var body: some View {
        VStack(alignment: .center) {
            Spacer(minLength: 0)
            HStack {
                Spacer(minLength: 0)
                AsyncImage(url: URL(string: poke.spriteUrl)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                Spacer(minLength: 0)
            }
            
            Text("#\(poke.pokemonId) \(poke.name.capitalized)")
                .pokeWhiteText(.caption)
                .padding(.bottom, 10)
        }
        .background(content: {
            RoundedRectangle(cornerRadius: 16)
                .fill(.background)
                .shadow(color: Color.secondary, radius: 5)
        })
        .padding()
        
    }
}

#Preview {
    PokeCollectionCell(poke: Pokemon())
}
