//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Иван Легенький on 23.12.2023.
//

import SwiftUI
import WidgetKit

@main
struct ExpenseTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            RootView {
                ContentView()
                    .onAppear {
                        WidgetCenter.shared.reloadAllTimelines()
                    }
            }
        }
        .modelContainer(for: [Transaction.self])
    }
}
