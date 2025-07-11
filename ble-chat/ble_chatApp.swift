//
//  ble_chatApp.swift
//  ble-chat
//
//  Created by Jacob Senecal on 7/10/25.
//

import SwiftUI

@main
struct ble_chatApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
