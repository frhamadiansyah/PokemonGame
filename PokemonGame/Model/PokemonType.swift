//
//  PokemonType.swift
//  PokemonGame
//
//  Created by Fandrian Rhamadiansyah on 09/08/24.
//

import Foundation
import SwiftUI

enum PokemonType: String {
    
    case normal, fighting, flying, poison, ground, rock, bug, ghost, steel, fire, water, grass, electric, psychic, ice, dragon, dark, fairy, shadow, unknown
    
    func getColor() -> Color {
        switch self {
        case .normal:
            return Color(hex: "A8A77A")
        case .fighting:
            return Color(hex: "C22E28")
        case .flying:
            return Color(hex: "A98FF3")
        case .poison:
            return Color(hex: "A33EA1")
        case .ground:
            return Color(hex: "E2BF65")
        case .rock:
            return Color(hex: "B6A136")
        case .bug:
            return Color(hex: "A6B91A")
        case .ghost:
            return Color(hex: "735797")
        case .steel:
            return Color(hex: "B7B7CE")
        case .fire:
            return Color(hex: "EE8130")
        case .water:
            return Color(hex: "6390F0")
        case .grass:
            return Color(hex: "7AC74C")
        case .electric:
            return Color(hex: "F7D02C")
        case .psychic:
            return Color(hex: "F95587")
        case .ice:
            return Color(hex: "96D9D6")
        case .dragon:
            return Color(hex: "6F35FC")
        case .dark:
            return Color(hex: "705746")
        case .fairy:
            return Color(hex: "D685AD")
        case .shadow:
            return Color(hex: "837050")
        case .unknown:
            return Color.primary
        }
    }
    
}

extension PokemonType: Identifiable {
    var id: RawValue { rawValue }
}
