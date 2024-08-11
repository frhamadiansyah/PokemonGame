//
//  PokeResponse.swift
//  PokemonGame
//
//  Created by Fandrian Rhamadiansyah on 09/08/24.
//

import Foundation

let spriteBaseUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"

struct PokeResponse: Decodable {
    let results : [Pokemon]
    
}

struct Pokemon: Decodable, Identifiable {
    let id: String
    let name: String
    let url: String
    let pokemonId: String
    let spriteUrl: String
    
    enum CodingKeys: String, CodingKey {
        case url = "url"
        case name = "name"
    }
    
    init(id: String, name: String, url: String, pokemonId: String, spriteUrl: String) {
        self.id = id
        self.name = name
        self.url = url
        self.pokemonId = pokemonId
        self.spriteUrl = spriteUrl
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        url = try container.decode(String.self, forKey: .url)
        id = url
        pokemonId = url.getPokemonIdFromUrl()
        spriteUrl = "\(spriteBaseUrl)\(pokemonId).png"
        
    }
    
    // for dummy model
    init() {
        id = "1"
        name = "Bulbasaur"
        url = "https://pokeapi.co/api/v2/pokemon/1/"
        pokemonId = "1"
        spriteUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"
    }
        
}
