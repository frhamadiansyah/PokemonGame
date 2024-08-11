//
//  ContentView.swift
//  PokemonGame
//
//  Created by Fandrian Rhamadiansyah on 09/08/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject private var tabController = TabController()
    
    var body: some View {
        TabView(selection: $tabController.activeTab) {
            HomeView()
                .tag(Tab.home)
                .tabItem {
                    VStack {
                        Image(systemName: "magnifyingglass")
                        Text("PokeDex")
                    }
                }
            MyPokemonView()
                .tag(Tab.download)
                .tabItem {
                    VStack {
                        Image(systemName: "tray.circle")
                        Text("My Pokemon")
                    }
                }
        }
        .environmentObject(tabController)
    }
}


enum Tab {
    case home
    case download
}


class TabController: ObservableObject {
    @Published var activeTab = Tab.home
    
    func open(_ tab: Tab) {
        activeTab = tab
    }
}


private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView()
}
