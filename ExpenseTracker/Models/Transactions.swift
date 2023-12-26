//
//  Transactions.swift
//  ExpenseTracker
//
//  Created by Иван Легенький on 23.12.2023.
//

import SwiftUI
import SwiftData

@Model
class Transaction {
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
    
    @Transient
    var color: Color {
        return tints.first(where: {$0.color == tintColor})?.value ?? appTint
    }
    
    @Transient
    var tint: TintColor? {
        return tints.first(where: {$0.color == tintColor})
    }
    
    @Transient
    var rawCategory: Category? {
        return Category.allCases.first(where: {category == $0.rawValue})
    }
}

var mockTransactions: Transaction {
    Transaction.init(title: "Magic Mouse", remarks: "Apple Product", amount: 189.0, dateAdded: .now, category: .expenses, tintColor: .init(color: "Red", value: .red))
}
