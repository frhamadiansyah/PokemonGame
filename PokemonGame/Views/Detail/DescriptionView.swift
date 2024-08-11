//
//  DescriptionView.swift
//  PokemonGame
//
//  Created by Fandrian Rhamadiansyah on 09/08/24.
//

import SwiftUI

struct DescriptionView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var vm: DetailViewModel
    
    init(_ poke: Pokemon) {
        _vm = StateObject(wrappedValue: DetailViewModel(poke))
    }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State private var catchPokemonSuccess: Bool = false
    @State private var catchPokemonFail: Bool = false
    @State private var nickname = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 5) {
                
                // image
                AsyncImage(url: URL(string: vm.poke.spriteUrl)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 250, maxHeight: 250)
                } placeholder: {
                    ProgressView()
                }
                
                
                //title
                Text(vm.poke.name.capitalized)
                    .pokeWhiteText(.title, borderWidth: 3)
                
                if let model = vm.model {
                    
                    HStack {
                        Text("Height : \(String(format: "%.1f", model.height)) m")
                            .font(.body)
                            .padding(.horizontal)
                        Spacer()
                        Text("Weight : \(String(format: "%.1f", model.weight)) Kg")
                            .font(.body)
                            .padding(.horizontal)
                    }
                    .foregroundColor(.black)
                    .padding(10)
                    .background(content: {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.white)
                    })
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.black, lineWidth: 1)
                    }
                    .padding(.horizontal)
                    
                    // type
                    HStack(spacing: 10) {
                        ForEach(model.types, id: \.self) { type in
                            Text(type.rawValue.uppercased())
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .padding(10)
                                .background(content: {
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(type.getColor())
                                })
                                .overlay {
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.black, lineWidth: 1)
                                }
                                .frame(maxWidth: .infinity)
                        }
                        
                        
                    }
                    .padding(10)
                    
                    Text("MOVES")
                        .fontWeight(.bold)
                        .font(.title2)
                        .padding(10)
                    
                    LazyVGrid(columns: columns, spacing: 10) {
                        if vm.showAllMoves {
                            ForEach(model.moves) { moves in
                                HStack {
                                    Spacer(minLength: 0)
                                    Text(moves.move.name ?? "EMPTY")
                                        .padding(5)
                                    Spacer(minLength: 0)
                                }
                                .background(content: {
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(.white)
                                })
                                .overlay {
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.black, lineWidth: 1)
                                }
                                
                                
                            }
                        } else {
                            ForEach(Array(model.moves[0..<4])) { moves in
                                HStack {
                                    Spacer(minLength: 0)
                                    Text(moves.move.name ?? "EMPTY")
                                        .padding(5)
                                    Spacer(minLength: 0)
                                }
                                .background(content: {
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(.white)
                                })
                                .overlay {
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.black, lineWidth: 1)
                                }
                            }
                            
                        }
                        
                    }
                    .padding(.horizontal)
                    
                    Button(action: {
                        vm.showAllMoves.toggle()
                    }, label: {
                        Text(vm.showAllMoves ? "HIDE MOVES" : "SHOW ALL MOVES")
                            .pokeWhiteText(.subheadline)
                    })
                    
                    Text("STATS")
                        .fontWeight(.bold)
                        .font(.title2)
                        .padding(10)
                    // Status
                    StatsView(vm: vm)
                    
                    Button(action: {
                        if vm.checkIfCatchSuccess() {
                            catchPokemonSuccess = true
                        } else {
                            catchPokemonFail = true
                        }
                        
                    }, label: {
                        HStack {
                            Spacer()
                            Text("CATCH!")
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .padding()
                            Spacer()
                        }
                        .background(content: {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.red)
                        })
                        .overlay {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.black, lineWidth: 1)
                        }
                        
                    })
                    .padding()
                    
                    
                    Spacer()
                    
                }
                
            }
        }
        .alert("You Caught This Pokemon!", isPresented: $catchPokemonSuccess) {
                    TextField("Enter This Pokemon Nickname", text: $nickname)
                    Button("OK", action: submit)
                } message: {
                    Text("Enter this pokemon's nickname")
                }
                .alert("Pokemon Run Away", isPresented: $catchPokemonFail) {
                            Button("OK", action: {})
                        } message: {
                            Text("Uh Oh, the pokemon run away :(")
                        }
        
        .modifier(ErrorHandle(showError: $vm.showError, error: vm.error, completion: { }))
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("#\(vm.poke.pokemonId) \(vm.poke.name.capitalized)")
        .onAppear {
            vm.loadDetails(url: vm.poke.url)
        }
        .gesture(DragGesture(minimumDistance: 20, coordinateSpace: .local)
            .onEnded({ value in
                if value.translation.width > 0 {
                    self.presentationMode.wrappedValue.dismiss()
                }
                
                
            })
        )
    }
    
    func submit() {
        Task {
            await vm.catchPokemon(nickName: nickname)
        }
    }
}

#Preview {
    DescriptionView(Pokemon())
}
