//
//  ConversationDetailView.swift
//  ble-chat
//
//  Created by Jacob Senecal on 7/11/25.
//

import SwiftUI

struct ConversationDetailView: View {
  var conversation: Conversation
  var loggedInUser: String

  @State var text = ""

  var body: some View {
    VStack {
      MessageListView(
        messages: conversation.messages,
        loggedInUser: "pid1",
        shouldShowParticipantInfo: conversation.participants.count > 2
      )

      MessageComposerView(
        messageText: $text,
      )
      .padding([.horizontal, .bottom])
    }
  }
}

#Preview {
  ConversationDetailView(
    conversation: Conversation(
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
//          id: "8", content: "message 4", createdAt: Date.now, sender: "pid3", receiver: "pid1"),
//        BleMessage(
//          id: "9", content: "message 4", createdAt: Date.now, sender: "pid1", receiver: "pid2"),
//        BleMessage(
//          id: "10", content: "message 10", createdAt: Date.now, sender: "pid1", receiver: "pid2"),
//        BleMessage(
//          id: "11", content: "message 11", createdAt: Date.now, sender: "pid1", receiver: "pid2"),
      ],
      participants: ["pid1", "pid2", "pid3"],
      lastUpdatedAt: Date.now
    ),
    loggedInUser: "pid1"
  )
}
