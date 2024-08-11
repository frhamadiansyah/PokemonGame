//
//  MyPokemonViewModel.swift
//  PokemonGame
//
//  Created by Fandrian Rhamadiansyah on 10/08/24.
//

import Foundation
import CoreData

class MyPokemonViewModel: ObservableObject {
    
    let manager = CoreDataManager.instance
    @Published var caughtPokemonEntity = [CaughtPokemon]()
    
    @Published var showError = false
    @Published var error: Error?
    
    @MainActor
    func fetchMyPokemon() async {
        do {
            let pokemons = try await fetchCaughtPokemon()
            caughtPokemonEntity = pokemons
        } catch {
            showError = true
            self.error = error
        }
        
    }
    
    
    func renameMyPokemon(_ caughtPokemon: CaughtPokemon) async {
        
        if let nickname = caughtPokemon.nickname {
            caughtPokemon.shownName = "\(nickname)-\(fibonacci(n: Int(caughtPokemon.renameCount)))"
            caughtPokemon.renameCount += 1
            
            do {
                try await manager.save()
                await fetchMyPokemon()
            } catch {
                showError = true
                self.error = error
            }
            
        }
       
    }
    
    func releaseMyPokemon(_ caughtPokemon: CaughtPokemon) async {
        manager.delete(caughtPokemon)
        
        do {
            try await manager.save()
            await fetchMyPokemon()
        } catch {
            showError = true
            self.error = error
        }
    }
    func returnRandomNumber() -> Int {
        return Int.random(in: 0..<100)
    }
    
    func checkIfReleaseSuccess() -> Bool {
        let number = Int.random(in: 0..<100)
        return number.isPrime
    }
    
    func fetchCaughtPokemon() async throws -> [CaughtPokemon] {
        let request = NSFetchRequest<CaughtPokemon>(entityName: "CaughtPokemon")
        
        let sort = NSSortDescriptor(keyPath: \CaughtPokemon.timestamp, ascending: true)
        request.sortDescriptors = [sort]
        return try await manager.context.perform {
            return try request.execute()
        }
    }
    
    func fibonacci(n: Int) -> Int {
        var seq: [Int] = n == 0 ? [0] : [0, 1]
        var curNum = 2
        while curNum < n {
            seq.append(seq[curNum - 1] + seq[curNum - 2])
            curNum += 1 }
        return seq.last ?? -1
    }
    
    
}
