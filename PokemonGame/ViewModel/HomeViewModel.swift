//
//  HomeViewModel.swift
//  PokemonGame
//
//  Created by Fandrian Rhamadiansyah on 09/08/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    let service: Requestable
    
    @Published var poke = [Pokemon]()
    @Published var filteredPoke = [Pokemon]()
    
    @Published var searchKeyword: String = ""
    
    @Published var showError = false
    @Published var error: Error?
    
    var cancel = Set<AnyCancellable>()
    
    init(service: Requestable = APIService()) {
        self.service = service
        loadItems()
        filterSearch()
    }
    
    let urlString = "https://pokeapi.co/api/v2/pokemon?limit=10000"
    
    func loadItems() {
        let request = URLRequest(url: URL(string: urlString)!)
        service.makes(request: request, decoder: JSONDecoder())
            .compactMap { result -> PokeResponse? in
                return result
            }
            .sink { [unowned self] response in
                switch response {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    self.showError = true
                    self.error = error
                }
            } receiveValue: { [unowned self] response in
                self.poke = response.results
                self.filteredPoke = response.results
            }
            .store(in: &cancel)

    }
    
    
    func filterSearch() {
        $searchKeyword
            .sink { text in
                if !text.isEmpty {
                    self.filteredPoke = self.poke.filter { $0.name.range(of: text, options: .caseInsensitive) != nil }
                } else {
                    self.filteredPoke = self.poke
                }
                
            }
            .store(in: &cancel)
    }
    
}
