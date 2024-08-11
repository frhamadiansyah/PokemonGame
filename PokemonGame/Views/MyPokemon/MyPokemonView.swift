//
//  MyPokemonView.swift
//  PokemonGame
//
//  Created by Fandrian Rhamadiansyah on 09/08/24.
//

import SwiftUI

struct MyPokemonView: View {
    @StateObject var vm = MyPokemonViewModel()
    
    @State private var showReleaseConfirmation: Bool = false
    @State private var pokemonActionQueue: CaughtPokemon?
    
    @State private var renameSuccess: Bool = false
    @State private var releaseSuccess: Bool = false
    @State private var releaseFail: Bool = false
    
    var body: some View {
        NavigationView{
            List {
                ForEach(vm.caughtPokemonEntity) { caughtPokemon in
                    HStack {
                        AsyncImage(url: URL(string: caughtPokemon.spriteUrl ?? "")) { image in
                            image
                        } placeholder: {
                            ProgressView()
                        }
                        
                        Text(caughtPokemon.shownName ?? "")
                        Spacer()
                        
                    }
                    
                    .swipeActions(allowsFullSwipe: false) {
                        Button {
                            Task {
                                await vm.renameMyPokemon(caughtPokemon)
                                renameSuccess.toggle()
                            }
                            
                        } label: {
                            Label("Rename", systemImage: "square.and.pencil")
                            
                        }
                        .tint(.indigo)
                        
                        Button {
                            pokemonActionQueue = caughtPokemon
                            showReleaseConfirmation.toggle()
                            
                            
                        } label: {
                            Label("Release", systemImage: "trash.fill")
                        }
                    }
                    .tint(.red)
                    
                }
                
            }
            .task {
                await vm.fetchMyPokemon()
            }
            .navigationTitle("My Pokemon")
            .modifier(ErrorHandle(showError: $vm.showError, error: vm.error, completion: { }))
            .alert("Rename Pokemon Success", isPresented: $renameSuccess) {
                Button(action: {
                    pokemonActionQueue = nil
                }, label: {
                    Text("OK")
                })
            } message: {
                Text("Rename Pokemon Success")
            }
            .alert("Release Fail", isPresented: $releaseFail) {
                Button(action: { }, label: {
                    Text("OK")
                })
            } message: {
                Text("Release Fail")
            }
            .alert("Release Success", isPresented: $releaseSuccess) {
                Button(action: { }, label: {
                    Text("OK")
                })
            } message: {
                Text("Release Success")
            }
            .alert("You're about to release this pokemon", isPresented: $showReleaseConfirmation) {
                Button(action: {
                    Task {
                        if let pokemon = pokemonActionQueue {
                            if vm.checkIfReleaseSuccess() {
                                await vm.releaseMyPokemon(pokemon)
                                releaseSuccess.toggle()
                            } else {
                                releaseFail.toggle()
                            }
                            
                        }
                    }
                }, label: {
                    Text("Release")
                })
            } message: {
                if let item = pokemonActionQueue {
                    Text("You're about to release \(item.nickname ?? ""), are you sure?")
                }
            }
        }
        
    }
}

#Preview {
    MyPokemonView()
}
