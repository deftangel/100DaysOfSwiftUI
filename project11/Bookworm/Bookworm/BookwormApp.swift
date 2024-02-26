//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Chris Hunter-Brown on 22/02/2024.
//

import SwiftUI

@main
struct BookwormApp: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
