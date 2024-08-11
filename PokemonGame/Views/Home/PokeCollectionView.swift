//
//  PokeCollectionView.swift
//  PokemonGame
//
//  Created by Fandrian Rhamadiansyah on 09/08/24.
//

import SwiftUI

struct PokeCollectionView: View {
    @ObservedObject var vm: HomeViewModel
    
    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            if !vm.filteredPoke.isEmpty {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(vm.filteredPoke) { poke in
                        NavigationLink {
                            DescriptionView(poke)
                        } label: {
                            PokeCollectionCell(poke: poke)
                        }
                        
                    }
                    
                }
            } else {
                Text("No Pokemon Found")
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

#Preview {
    PokeCollectionView(vm: HomeViewModel())
}
