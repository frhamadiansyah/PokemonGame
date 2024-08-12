//
//  MockService.swift
//  PokemonGameTests
//
//  Created by Fandrian Rhamadiansyah on 12/08/24.
//

import Foundation
import Combine

@testable import PokemonGame

struct MockService: Requestable {
    
    var mockDataType: MockDataType
    
    func makes<T: Decodable>(request: URLRequest, decoder: JSONDecoder) -> AnyPublisher<T?, Error> {
        
        if mockDataType == .null {
            return Fail(error: PokeError.noData)
                .eraseToAnyPublisher()
        } else {
            return Just(MockData.getMockData(type: mockDataType))
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
    }
    
}
