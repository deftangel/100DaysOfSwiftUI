//
//  ContentView.swift
//  HabitTracker
//
//  Created by Chris Hunter-Brown on 14/02/2024.
//

import SwiftUI

struct ContentView: View {
    @State var store = HabitStore()
    @State var addNewActivity = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(store.activities) { activity in
                    NavigationLink {
                        ActivityDetail(activity: activity, store: store)
                    } label: {
                        HStack {
                            Text(activity.name)
                            Spacer()
                            Text(String(activity.completionCount))
                        }
                    }
                }
                .onDelete(perform: { indexSet in
                    removeItems(at: indexSet)
                })
            }
            .navigationTitle("Activities")
            .toolbar {
                Button {
                    addNewActivity = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $addNewActivity, content: {
                AddActivity(store: store)
            })
        }
    }

    private func removeItems(at offsets: IndexSet) {
        store.activities.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
