//
//  StatsView.swift
//  PokemonGame
//
//  Created by Fandrian Rhamadiansyah on 09/08/24.
//

import SwiftUI

struct StatsView: View {
    @ObservedObject var vm: DetailViewModel
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            if let model = vm.model {
                ForEach(model.stats) { stat in
                    HStack {
                        Text(stat.stat.name.uppercased())
                            .fontWeight(.heavy)
                        Spacer()
                        Text("\(stat.base_stat)")
                            .fontWeight(.heavy)
                    }
                    .foregroundColor(.black)
                    .padding(10)
                    .background(content: {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.white)
                    })
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.black, lineWidth: 1)
                    }
                }
            }
        }
        .padding()
        
    }
}

#Preview {
    StatsView(vm: DetailViewModel(Pokemon()))
}
