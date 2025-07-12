//
//  ConversationsView.swift
//  ble-chat
//
//  Created by Jacob Senecal on 7/11/25.
//

import SwiftUI

struct ConversationsView: View {
  @EnvironmentObject var conversationViewModel: ConversationViewModel

  var body: some View {
    TabView {
      Tab("DMs", systemImage: "tray.and.arrow.down.fill") {
        NavigationStack {
          List {
            ForEach(conversationViewModel.conversations) { conversation in
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
