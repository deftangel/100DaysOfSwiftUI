//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Chris Hunter-Brown on 26/02/2024.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
