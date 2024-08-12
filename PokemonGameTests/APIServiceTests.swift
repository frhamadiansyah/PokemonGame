//
//  APIServiceTests.swift
//  PokemonGameTests
//
//  Created by Fandrian Rhamadiansyah on 12/08/24.
//

import XCTest
import Combine
@testable import PokemonGame

class APIServiceTests: XCTestCase {

    let dummyRequest = URLRequest(url: URL(string: "https://pokeapi.co/api/v2/pokemon/6")!)
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPokemonList() throws {
        
        let sut = MockService(mockDataType: .pokemonList)
        sut.makes(request: dummyRequest, decoder: JSONDecoder())
            .compactMap { res -> PokeResponse? in
                return res
            }
            .sink { error in
                print(error)
            } receiveValue: { response in
                let expectedResult = "bulbasaur"
                let result = response.results.first?.name
                
                XCTAssert(expectedResult == result, "Expected \(expectedResult), but got \(result) instead")
                
                let expectedId = "1"
                let resultId = response.results.first?.id
                
                XCTAssert(expectedResult == result, "Expected \(expectedId), but got \(resultId) instead")
            }

    }

    
    func testPokemonDetail() throws {
        
        let sut = MockService(mockDataType: .pokemonDetail)
        sut.makes(request: dummyRequest, decoder: JSONDecoder())
            .compactMap { res -> PokemonDetail? in
                return res
            }
            .sink { error in
                print(error)
            } receiveValue: { response in
                let expectedResult = "bulbasaur"
                let result = response.name
                
                XCTAssert(expectedResult == result, "Expected \(expectedResult), but got \(result) instead")
            }

    }
    
    func testPokemonNull() throws {
        
        let sut = MockService(mockDataType: .null)
        
        sut.makes(request: dummyRequest, decoder: JSONDecoder())
            .compactMap { res -> PokemonDetail? in
                return res
            }
            .sink { response in
                switch response {
                case .finished:
                    XCTFail("Error not received")
                case .failure(let error):
                    XCTAssert(error != nil, "error received")
                }
                
            } receiveValue: { response in
                XCTFail("Error not received")
            }

    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
