//
//  AddView.swift
//  project7
//
//  Created by Chris Hunter-Brown on 25/04/2023.
//

import SwiftUI

struct AddView: View {
    @State private var name = "New expense"
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    var expenses: Expenses
    
    @Environment(\.dismiss) var dismiss

    let types = ["Business", "Personal"]

    var body: some View {
        Form {
            Picker("Type", selection: $type) {
                ForEach(types, id: \.self) {
                    Text($0)
                }
            }

            TextField("Amount", value: $amount, format: .currency(code: "USD"))
                .keyboardType(.decimalPad)
        }
        .navigationTitle($name)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
