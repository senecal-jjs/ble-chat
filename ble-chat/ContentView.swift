//
//  ContentView.swift
//  ble-chat
//
//  Created by Jacob Senecal on 7/10/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    let messages = ["Message 1", "Message 2"]

    var body: some View {
        TabView {
            Tab("DMs", systemImage: "tray.and.arrow.down.fill") {
                NavigationStack {
                    List(messages) { message in
                        NavigationLink(message, value: message)
                    }.navigationDestination(for: String.self) { message in
                        ColorDetail(color: .blue)
                    }
                }
            }
            Tab("Rooms", systemImage: "tray.and.arrow.down.fill") {}
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ColorDetail: View {
    var color: Color


    var body: some View {
        color.navigationTitle(color.description)
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
