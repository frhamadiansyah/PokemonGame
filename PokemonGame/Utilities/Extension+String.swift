//
//  Extension+String.swift
//  PokemonGame
//
//  Created by Fandrian Rhamadiansyah on 09/08/24.
//

import Foundation

extension String {
    func getPokemonIdFromUrl() -> String {
        do {
            let regex = try NSRegularExpression(pattern: "(\\d+)")
            let results = regex.matches(in: self,
                                        range: NSRange(self.startIndex..., in: self))
            let stringArray = results.map {
                String(self[Range($0.range, in: self)!])
            }
            return stringArray[1]
            
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return ""
        }
    }
}

extension Int {
    var isPrime: Bool {
        guard self >= 2     else { return false }
        guard self != 2     else { return true  }
        guard self % 2 != 0 else { return false }
        return !stride(from: 3, through: Int(sqrt(Double(self))), by: 2).contains { self % $0 == 0 }
    }
}
