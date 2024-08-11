//
//  HomeView.swift
//  PokemonGame
//
//  Created by Fandrian Rhamadiansyah on 09/08/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var vm = HomeViewModel()
    var body: some View {
        NavigationView {
            VStack {
                PokeCollectionView(vm: vm)
                    .searchable(text: $vm.searchKeyword)
            }
            .modifier(ErrorHandle(showError: $vm.showError, error: vm.error, completion: { }))
            .navigationTitle("Pokédex")
        }
    }
}
#Preview {
    HomeView()
}
