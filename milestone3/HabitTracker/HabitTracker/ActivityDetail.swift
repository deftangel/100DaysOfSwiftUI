//
//  ActivityDetail.swift
//  HabitTracker
//
//  Created by Chris Hunter-Brown on 14/02/2024.
//

import SwiftUI

struct ActivityDetail: View {
    @State var activity: Activity
    let store: HabitStore

    var body: some View {
        List {
            if activity.description.isEmpty == false {
                Section {
                    Text(activity.description)
                }
            }

            Section {
                Text("Completion count: \(activity.completionCount)")

                Button("Mark Completed") {
                    incrementCompletionCount()
                }
            }
        }
        .navigationTitle(activity.name)
    }

    private func incrementCompletionCount() {
        var incrementedActivty = activity
        incrementedActivty.completionCount += 1
        if let index = store.activities.firstIndex(of: activity) {
            store.activities[index] = incrementedActivty
            activity = incrementedActivty
        }
    }
}

#Preview {
    ActivityDetail(activity: .example, store: HabitStore())
}
