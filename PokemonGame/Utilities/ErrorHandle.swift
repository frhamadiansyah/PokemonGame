//
//  ErrorHandle.swift
//  PokemonGame
//
//  Created by Fandrian Rhamadiansyah on 09/08/24.
//

import SwiftUI

struct ErrorHandle: ViewModifier {
    @Binding var showError: Bool
    var error: Error?
    let completion: () -> Void
    
    func body(content: Content) -> some View {
        content
            .alert("Error", isPresented: $showError) {
                Button(action: completion) {
                    Text("OK")
                }
            } message: {
                Text(error?.localizedDescription ?? "Sorry, there's a disturbance right now")
            }
            
    }
}
