//
//  APIService.swift
//  PokemonGame
//
//  Created by Fandrian Rhamadiansyah on 09/08/24.
//

import Foundation
import Combine

enum PokeError: Error {
    case noData
}

protocol Requestable {
    func makes<T: Decodable>(request: URLRequest, decoder: JSONDecoder) -> AnyPublisher<T?, Error>
}

struct APIService: Requestable {
    
    func makes<T: Decodable>(request: URLRequest, decoder: JSONDecoder) -> AnyPublisher<T?, Error> {
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap({ output in
                do {
                    let result = try decoder.decode(T.self, from: output.data)
                    return result
                    
                } catch {
                    print(error.localizedDescription)
                    throw error
                }
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
