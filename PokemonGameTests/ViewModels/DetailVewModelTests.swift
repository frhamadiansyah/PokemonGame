//
//  DetailVewModelTests.swift
//  PokemonGameTests
//
//  Created by Fandrian Rhamadiansyah on 12/08/24.
//

import XCTest
import Combine
@testable import PokemonGame

class DetailViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadDetails() throws {
        let sut = DetailViewModel(Pokemon(), service: MockService(mockDataType: .pokemonDetail))
        let urlString = "https://pokeapi.co/api/v2/pokemon/1/"
        
        let expectation = expectation(description: "Details Loaded")
        sut.loadDetails(url: urlString)
        
        sut.$model.sink { output in
            if let model = output {
                let expectedResult = "bulbasaur"
                let result = model.name
                
                XCTAssert(expectedResult == result, "Expected \(expectedResult), but got \(result) instead")
                
                let expectedType: [PokemonType] = [.grass, .poison]
                let resultType = model.types
                XCTAssert(expectedType == resultType, "Expected \(expectedType), but got \(resultType) instead")
                
                expectation.fulfill()
            } else {
                XCTFail("Result nil")
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testNoDetailReceived() throws {
        let sut = DetailViewModel(Pokemon(), service: MockService(mockDataType: .null))
        let urlString = "https://pokeapi.co/api/v2/pokemon/1/"
        
        let expectation = expectation(description: "Error Throwed")
        sut.loadDetails(url: urlString)
        
        
        sut.$error.sink { error in
            
            XCTAssert(error != nil, "Error not received")
            XCTAssert(sut.showError == true, "Error alert not showed")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
