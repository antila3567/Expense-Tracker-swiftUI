//
//  Transactions.swift
//  ExpenseTracker
//
//  Created by Иван Легенький on 23.12.2023.
//

import SwiftUI

struct Transaction: Identifiable {
    let id: UUID = .init()
    
    var title: String
    var remarks: String
    var amount: Double
    var dateAdded: Date
    var category: String
    var tintColor: String
    
    init(title: String, remarks: String, amount: Double, dateAdded: Date, category: Category, tintColor: TintColor) {
        self.title = title
        self.remarks = remarks
        self.amount = amount
        self.dateAdded = dateAdded
        self.category = category.rawValue
        self.tintColor = tintColor.color
    }
    
    var color: Color {
        return tints.first(where: {$0.color == tintColor})?.value ?? appTint
    }
}


var sampleTransactions: [Transaction] = [
    .init(title: "Magic Keyboard", remarks: "Apple Product", amount: 129, dateAdded: .now, category: .expenses, tintColor: tints.randomElement()!),
    .init(title: "Apple Music", remarks: "Subscription", amount: 10.88, dateAdded: .now, category: .expenses, tintColor: tints.randomElement()!),
    .init(title: "Youtube Premium", remarks: "Google subscription", amount: 7.20, dateAdded: .now, category: .expenses, tintColor: tints.randomElement()!),
    .init(title: "Payment", remarks: "Payment Received!", amount: 2499, dateAdded: .now, category: .income, tintColor: tints.randomElement()!),
]
