//
//  PokeDetail.swift
//  PokemonGame
//
//  Created by Fandrian Rhamadiansyah on 09/08/24.
//

import Foundation
import SwiftUI

struct PokemonDetail: Decodable {
    let id: Int
    let name: String
    let height: Float
    let weight: Float
    
    let types: [PokemonType]
    
    let stats: [PokeStat]
    
    let moves: [PokeMovesDetail]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case height
        case weight
        case types
        case stats
        case moves
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        let rawheight = try container.decode(Int.self, forKey: .height)
        let rawweight = try container.decode(Int.self, forKey: .weight)
        height = Float(rawheight) / 10 // convert in game unit to m
        weight = Float(rawweight) / 10 // convert in game unit to kg
        
        let rawTypes = try container.decode([RawPokeType].self, forKey: .types)
        
        types = rawTypes.map { PokemonType.init(rawValue: $0.type.name) ?? .unknown }
        stats = try container.decode([PokeStat].self, forKey: .stats)
        do {
            moves = try container.decode([PokeMovesDetail].self, forKey: .moves)
        } catch {
            fatalError("Couldn't parse moves?")
        }
        
    }
    
}

struct PokeMovesDetail: Decodable, Identifiable {
    var id: String
    let move: PokeMove
    
    enum CodingKeys: String, CodingKey {
        case id
        case move
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = UUID().uuidString
        move = try container.decode(PokeMove.self, forKey: .move)
    }
}

struct PokeMove: Decodable {
    let name: String?
}

struct RawPokeType: Decodable {
    let slot: Int
    let type: NameUrl
}

struct NameUrl: Decodable {
    let name: String
    let url: String
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}

struct PokeStat: Decodable, Identifiable {
    var id: String
    let base_stat: Int
    let stat: NameUrl
    
    enum CodingKeys: String, CodingKey {
        case base_stat
        case stat
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = UUID().uuidString
        base_stat = try container.decode(Int.self, forKey: .base_stat)
        let rawStat = try container.decode(NameUrl.self, forKey: .stat)
        
        if rawStat.name == "special-attack" {
            stat = NameUrl(name: "Sp. Atk", url: rawStat.url)
        } else if rawStat.name == "special-defense" {
            stat = NameUrl(name: "Sp. Def", url: rawStat.url)
        } else {
            stat = rawStat
        }
    }
}
