//
//  DetailViewModel.swift
//  PokemonGame
//
//  Created by Fandrian Rhamadiansyah on 09/08/24.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    let manager = CoreDataManager.instance
    
    let service: Requestable
    
    var cancel = Set<AnyCancellable>()
    
    @Published var model: PokemonDetail?
    
    @Published var poke: Pokemon
    
    @Published var showError = false
    @Published var error: Error?
    
    @Published var showAllMoves: Bool = false
    
    
    init(_ poke: Pokemon, service: Requestable = APIService()) {
        self.poke = poke
        self.service = service
    }
    
    func loadDetails(url: String) {
        let request = URLRequest(url: URL(string: url)!)
        service.makes(request: request, decoder: JSONDecoder())
            .compactMap { response -> PokemonDetail? in
                return response
            }
            .sink { [unowned self] response in
                switch response {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    self.showError = true
                    self.error = error
                }
            } receiveValue: { [unowned self] detail in
                self.model = detail
            }.store(in: &cancel)
    }
    
    
    func checkIfCatchSuccess() -> Bool {
        return Bool.random()
    }
    
//    @MainActor
    func catchPokemon(nickName: String) async {
        let newPokemon = CaughtPokemon(context: manager.context)
        newPokemon.translateCaughtPokemonModel(model: poke, nickname: nickName)
        newPokemon.shownName = nickName
        newPokemon.renameCount = 0
        newPokemon.timestamp = Date()
        
        do {
            try await manager.save()
        } catch {
            self.showError = true
            self.error = error
        }
        
    }
    
    
}
