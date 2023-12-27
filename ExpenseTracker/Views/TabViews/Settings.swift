//
//  Settings.swift
//  ExpenseTracker
//
//  Created by Иван Легенький on 23.12.2023.
//

import SwiftUI

struct Settings: View {
    @AppStorage("userName") private var userName: String = ""
    @AppStorage("isAppLockEnabled") private var isAppLockEnabled: Bool = false
    @AppStorage("lockWhenAppInBg") private var lockWhenAppInBg: Bool = false
    
    @State private var changeTheme: Bool = false
    
    @Environment(\.colorScheme) private var scheme
    
    var body: some View {
        NavigationStack {
            List {
                Section("User Name") {
                    TextField("Peter", text: $userName)
                }
                
                Section("App Lock") {
                    Toggle("Enable App Lock", isOn: $isAppLockEnabled)
                    
                    if isAppLockEnabled {
                        Toggle("Lock When App In Backgroud", isOn: $lockWhenAppInBg)
                    }
                }
                Section("Appearance") {
                    Button("Change theme") {
                        changeTheme.toggle()
                    }
                    .foregroundColor(.primary)
                }
            }
            .navigationTitle("Settings")
        }

        .sheet(isPresented: $changeTheme, content: {
            ThemeSwitcherView(scheme: scheme)
                .presentationDetents([.height(410)])
                .presentationBackground(.clear)
        })
    }
}

#Preview {
    ContentView()
}
