//
//  Activity.swift
//  HabitTracker
//
//  Created by Chris Hunter-Brown on 14/02/2024.
//

import Foundation

struct Activity: Identifiable, Codable, Equatable {
    var id = UUID()
    var name: String
    var description: String
    var completionCount = 0

    static let example = Activity(name: "Guitar practice", description: "30 mins practice each day")
}
