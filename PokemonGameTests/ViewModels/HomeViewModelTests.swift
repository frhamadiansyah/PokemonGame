//
//  HomeViewModelTests.swift
//  PokemonGameTests
//
//  Created by Fandrian Rhamadiansyah on 12/08/24.
//

import XCTest
import Combine
@testable import PokemonGame

class HomeViewModelTests: XCTestCase {


    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadList() throws {
        let sut = HomeViewModel(service: MockService(mockDataType: .pokemonList))

        sut.loadItems()
        let expectation = expectation(description: "Details Loaded")
        
        sut.$poke.first().sink { pokemon in
            print(sut.poke.count)

            XCTAssert(!sut.poke.isEmpty, "Empty list")
                
            XCTAssert(!sut.filteredPoke.isEmpty, "Empty list")
                
            XCTAssert(sut.poke.count == 1126, "Count different, expect 1126, instead got \(sut.poke.count)")
                
            XCTAssert(sut.filteredPoke.count == 1126, "Count different, expect unfiltered 1126, instead got \(sut.poke.count)")
                            
            expectation.fulfill()
            
        }

        wait(for: [expectation], timeout: 5)
    }
    
    func testFilteredList() throws {
        let sut = HomeViewModel(service: MockService(mockDataType: .pokemonList))

        sut.loadItems()
        
        sut.searchKeyword = "bulbasaur"
        let expectation = expectation(description: "Details Loaded")
        
        sut.$filteredPoke.first().sink { pokemon in
            print(sut.poke.count)

            XCTAssert(!sut.poke.isEmpty, "Empty list")
                
            XCTAssert(!sut.filteredPoke.isEmpty, "Empty list")
                
            XCTAssert(sut.poke.count == 1126, "Count different, expect 1126, instead got \(sut.poke.count)")
                
            XCTAssert(sut.filteredPoke.count == 1, "Count different, expect unfiltered 1126, instead got \(sut.poke.count)")
                            
            expectation.fulfill()
            
        }

        wait(for: [expectation], timeout: 5)
    }
    
    func testNoListReceived() throws {
        let sut = HomeViewModel(service: MockService(mockDataType: .null))
        
        let expectation = expectation(description: "Error Throwed")
        sut.loadItems()
        
        
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
