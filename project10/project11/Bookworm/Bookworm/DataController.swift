//
//  DataController.swift
//  Bookworm
//
//  Created by Chris Hunter-Brown on 22/02/2024.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Bookworm")

    init() {
        container.loadPersistentStores { description, error in
            if let error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
