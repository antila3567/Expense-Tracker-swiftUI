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
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    ContentView()
}
