//
//  AddActivity.swift
//  HabitTracker
//
//  Created by Chris Hunter-Brown on 14/02/2024.
//

import SwiftUI

struct AddActivity: View {
    @State private var name = ""
    @State private var description = ""

    var store: HabitStore

    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                TextField("Description", text: $description)
            }
            .navigationTitle("Add new activity")
            .toolbar {
                Button("Save") {
                    let activity = Activity(name: name, description: description)
                    store.activities.append(activity)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    let store = HabitStore()
    return AddActivity(store: store)
}
