//
//  ContentView.swift
//  ble-chat
//
//  Created by Jacob Senecal on 7/10/25.
//

import CoreData
import Foundation
import SwiftUI

struct ContentView: View {
  @Environment(\.managedObjectContext) private var viewContext

  @State var loggedInUser: String? = "pid1"

  let conversations = [
    Conversation(
      id: "1",
      name: "Convo 1",
      messages: [
//        BleMessage(
//          id: "1", content: "message 1", createdAt: Date.now, sender: "pid1", receiver: "pid2"),
//        BleMessage(
//          id: "2", content: "message 2", createdAt: Date.now, sender: "pid2", receiver: "pid1"),
//        BleMessage(
//          id: "3", content: "message 3", createdAt: Date.now, sender: "pid2", receiver: "pid1"),
//        BleMessage(
//          id: "4", content: "message 4", createdAt: Date.now, sender: "pid1", receiver: "pid2"),
//        BleMessage(
//          id: "5", content: "message 4", createdAt: Date.now, sender: "pid1", receiver: "pid2"),
//        BleMessage(
//          id: "6", content: "message 4", createdAt: Date.now, sender: "pid1", receiver: "pid2"),
//        BleMessage(
//          id: "7", content: "message 4", createdAt: Date.now, sender: "pid1", receiver: "pid2"),
//        BleMessage(
//          id: "8", content: "message 4", createdAt: Date.now, sender: "pid1", receiver: "pid2"),
//        BleMessage(
//          id: "9", content: "message 4", createdAt: Date.now, sender: "pid1", receiver: "pid2"),
      ],
      participants: ["pid1", "pid2"],
      lastUpdatedAt: Date.now
    )
  ]

  var body: some View {
    TabView {
      Tab("DMs", systemImage: "tray.and.arrow.down.fill") {
        NavigationStack {
          List {
            ForEach(conversations) { conversation in
              NavigationLink(conversation.name, value: conversation)
            }
          }
          .navigationDestination(for: Conversation.self) { conversation in
            ConversationDetailView(conversation: conversation, loggedInUser: "pid2")
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
  ContentView().environment(
    \.managedObjectContext, PersistenceController.preview.container.viewContext)
}
