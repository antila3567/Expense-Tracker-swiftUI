//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Иван Легенький on 23.12.2023.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isFirstTime") private var isFirstTime: Bool = true
    
    @State private var activeTab: Tab = .resents
    
    var body: some View {
        TabView(selection: $activeTab) {
            Recents()
                .tag(Tab.resents)
                .tabItem { Tab.resents.tabContent }
            Search()
                .tag(Tab.search)
                .tabItem { Tab.search.tabContent }
            Graphs()
                .tag(Tab.charts)
                .tabItem { Tab.charts.tabContent }
            Settings()
                .tag(Tab.settings)
                .tabItem { Tab.settings.tabContent }
        }
        .tint(appTint)
        .sheet(isPresented: $isFirstTime, content: {
            IntroScreen()
                .interactiveDismissDisabled()
        })
    }
}

#Preview {
    ContentView()
}
