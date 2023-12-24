//
//  Points.swift
//  ExpenseTracker
//
//  Created by Иван Легенький on 23.12.2023.
//

import SwiftUI

struct Point: Identifiable {
    let id: UUID = .init()
    let symbol: String
    let title: String
    let subtitle: String
}

let points: [Point] = [
    .init(symbol: "dollarsign", title: "Transactions", subtitle: "Keep track of your earnings and expenses."),
    .init(symbol: "chart.bar.fill", title: "Visual Charts", subtitle: "View your transactions using eye-catching graphic representation."),
    .init(symbol: "magnifyingglass", title: "Advanced Filters", subtitle: "Find the expenses you want by advance search and filtering."),
]


