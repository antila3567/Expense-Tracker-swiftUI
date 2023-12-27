//
//  TransactionView.swift
//  ExpenseTracker
//
//  Created by Иван Легенький on 24.12.2023.
//

import SwiftUI
import WidgetKit

struct TransactionView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    var editTransactions: Transaction?
    
    @State private var title: String = ""
    @State private var remarks: String = ""
    @State private var amount: Double = .zero
    @State private var dateAdded: Date = .now
    @State private var category: Category = .expenses
    
    @State var tint: TintColor = tints.randomElement()!
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 15) {
                Text("Preview")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .hSpacing(.leading)
                
                TransactionCardView(transaction: .init(
                    title: title.isEmpty ? "Title" : title,
                    remarks: remarks.isEmpty ? "Remarks" : remarks,
                    amount: amount,
                    dateAdded: dateAdded,
                    category: category,
                    tintColor: tint
                ))
                
                CustomSection("Title", "Magic mouse", value: $title)
                
                CustomSection("Remarks", "Apple Product", value: $remarks)
                
                VStack(alignment: .leading, spacing: 10 ,content: {
                    Text("Amount & Category")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .hSpacing(.leading)
                    
                    HStack(spacing: 15) {
                        HStack(spacing: 4) {
                            Text(currencySymbol)
                                .font(.callout.bold())
                            
                            TextField("0.0", value: $amount, formatter: numberFormatter)
                                .keyboardType(.decimalPad)
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 12)
                        .background(.background, in: .rect(cornerRadius: 10))
                        .frame(maxWidth: 130)
                        
                        CategoryCheckBox()
                    }
                })
                
                VStack(alignment: .leading, spacing: 10 ,content: {
                    Text("Date")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .hSpacing(.leading)
                    
                    DatePicker("", selection: $dateAdded, displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 10)
                        .background(.background, in: .rect(cornerRadius: 10))
                })
            }
            .padding(15)
        }
        .navigationTitle("\(editTransactions != nil ? "Edit" : "Add") Transaction")
        .background(.gray.opacity(0.15))
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing, content: {
                Button("Save", action: save)
            })
        })
        .onAppear(perform: {
            if let editTransactions {
                title = editTransactions.title
                remarks = editTransactions.remarks
                amount = editTransactions.amount
                dateAdded = editTransactions.dateAdded
                if let category = editTransactions.rawCategory {
                    self.category = category
                }
                if let tint = editTransactions.tint {
                    self.tint = tint
                }
            }
        })
    }
    
    @ViewBuilder
    func CategoryCheckBox() -> some View {
        HStack(spacing: 10) {
            ForEach(Category.allCases, id: \.rawValue) { category in
                HStack(spacing: 5) {
                    ZStack {
                        Image(systemName: "circle")
                            .font(.title3)
                            .foregroundStyle(appTint)
                        
                        if self.category == category {
                            Image(systemName: "circle.fill")
                                .font(.caption)
                                .foregroundStyle(appTint)
                        }
                    }
                    Text(category.rawValue)
                        .font(.caption)
                }
                .contentShape(.rect)
                .onTapGesture {
                    self.category = category
                }
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .hSpacing(.leading)
        .background(.background, in: .rect(cornerRadius: 10))
    }
    
    @ViewBuilder
    func CustomSection(_ title: String, _ hint: String, value: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 10, content: {
            Text(title)
                .font(.caption)
                .foregroundStyle(.gray)
                .hSpacing(.leading)
            
            TextField(hint, text: value)
                .padding(.horizontal, 15)
                .padding(.vertical, 12)
                .background(.background, in: .rect(cornerRadius: 10))
        })
    }
    
    func save() {
        if editTransactions != nil {
            editTransactions?.title = title
            editTransactions?.remarks = remarks
            editTransactions?.amount = amount
            editTransactions?.category = category.rawValue
            editTransactions?.dateAdded = dateAdded
            Toast.shared.present(title: "Note Changed", symbol: "scribble")
        } else {
            let transaction = Transaction(
                title: title,
                remarks: remarks,
                amount: amount,
                dateAdded: dateAdded,
                category: category,
                tintColor: tint
            )
            
            context.insert(transaction)
            Toast.shared.present(title: "Note Created", symbol: "plus")
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            WidgetCenter.shared.reloadAllTimelines()
        }

        dismiss()
    }
    
    var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
        formatter.currencySymbol = "₴ "
        
        return formatter
    }
}

#Preview {
    NavigationStack {
        TransactionView()
    }
}
