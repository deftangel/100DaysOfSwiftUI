//
//  Activities.swift
//  HabitTracker
//
//  Created by Chris Hunter-Brown on 14/02/2024.
//

import SwiftUI

@Observable
class HabitStore {
    var activities = [Activity]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(activities) {
                UserDefaults.standard.set(encoded, forKey: "activities")
            }
        }
    }

    init() {
        if let savedActivities = UserDefaults.standard.data(forKey: "activities") {
            if let decoded = try? JSONDecoder().decode([Activity].self, from: savedActivities) {
                activities = decoded
                return
            }
        }
        activities = []
    }
}
