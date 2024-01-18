//
//  ContentView.swift
//  project7
//
//  Created by Chris Hunter-Brown on 25/04/2023.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
    
    var personal: [ExpenseItem] {
        return items.filter { $0.type == "Personal"}
    }
    
    var busines: [ExpenseItem] {
        return items.filter { $0.type == "Business"}
    }
}

struct ContentView: View {
    @State var expenses = Expenses()
    @State private var showingAddExpense = false

    var body: some View {
        NavigationStack {
            List {
                if expenses.personal.count > 0  {
                    Section("Personal") {
                        ForEach(expenses.personal) { item in
                            ViewRow(item: item)
                        }
                        .onDelete { indexSet in
                            removeItems(at: indexSet, from: expenses.personal)
                        }
                    }
                }
                if expenses.busines.count > 0  {
                    Section("Business") {
                        ForEach(expenses.busines) { item in
                            ViewRow(item: item)
                        }
                        .onDelete { indexSet in
                            removeItems(at: indexSet, from: expenses.busines)
                        }
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet, from inputArray: [ExpenseItem]) {
        
        var offsetsToRemove = IndexSet()
        
        for deletedOffset in offsets {
            let item = inputArray[deletedOffset]
            if let index = expenses.items.firstIndex(of: item) {
                offsetsToRemove.insert(index)
            }
        }
        
        expenses.items.remove(atOffsets: offsetsToRemove)
    }
}

struct ViewRow: View {
    let item: ExpenseItem
    
    var body: some View {
        HStack {
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.headline)
                }

                Spacer()
            Text(item.amount, format: .localCurrency)
            }
        .expenseDecoration(amount: item.amount)
    }
}

extension View {
    func expenseDecoration(amount: Double) -> some View {
        modifier(ExpenseDecoration(amount: amount))
    }
}

struct ExpenseDecoration: ViewModifier {
    
    let amount: Double
    
    func body(content: Content) -> some View {
        if amount < 10.0 {
            content
                .foregroundStyle(.gray)
        } else if amount > 10.0 {
            content
                .foregroundStyle(.red)
        } else {
            content
                .foregroundStyle(.black)
        }
  }
}

#Preview {
    ContentView()
}
