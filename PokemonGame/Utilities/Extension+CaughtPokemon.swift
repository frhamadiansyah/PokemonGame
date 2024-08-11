//
//  Extension+CaughtPokemon.swift
//  PokemonGame
//
//  Created by Fandrian Rhamadiansyah on 11/08/24.
//

import Foundation

extension CaughtPokemon {
    
    func translateCaughtPokemonModel(model: Pokemon, nickname: String) {
        self.id = UUID().uuidString
        self.name = model.name
        self.pokemonId = model.pokemonId
        self.url = model.url
        self.spriteUrl = model.spriteUrl
        self.nickname = nickname
        
    }
    
}
