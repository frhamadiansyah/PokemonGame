//
//  MockData.swift
//  PokemonGameTests
//
//  Created by Fandrian Rhamadiansyah on 12/08/24.
//

import Foundation
@testable import PokemonGame

enum MockDataType: String {
    case pokemonList = "mockPokemonList"
    case pokemonDetail = "mockPokemonDetail"
    case null
    
}


class MockData {
    
    static func getPokeResponse(type: MockDataType) -> PokeResponse? {
        if let data = readLocalFile(forName: type.rawValue) {
            do {
                let result = try JSONDecoder().decode(PokeResponse.self, from: data)
                return result
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return nil
    }

    static func getMockData<T:Decodable>(type: MockDataType) -> T? {
        if let data = readLocalFile(forName: type.rawValue) {
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                return result
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    private static func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle(for: MockData.self).path(forResource: name, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
}
