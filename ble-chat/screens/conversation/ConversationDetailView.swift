//
//  ConversationDetailView.swift
//  ble-chat
//
//  Created by Jacob Senecal on 7/11/25.
//

import Combine
import SwiftUI

struct ConversationDetailView: View {
  var conversation: Conversation
  var viewerId: String

  @State var newMessage: String = ""

  var body: some View {
    ScrollViewReader { proxy in
      ScrollView {
        LazyVStack {
          ForEach(conversation.messages) { message in
            MessageView(message: message, viewerId: viewerId)
          }
        }
        .onReceive(Just(conversation.messages)) { _ in
          withAnimation {
            proxy.scrollTo(conversation.messages.last, anchor: .bottom)
          }

        }.onAppear {
          withAnimation {
            proxy.scrollTo(conversation.messages.last, anchor: .bottom)
          }
        }
      }
    }
    .navigationTitle(conversation.name)

    // send new message
    HStack {
      TextField("Send a message", text: $newMessage)
        .textFieldStyle(.roundedBorder)

      Button(action: sendMessage) {
        Image(systemName: "paperplane")
      }
    }
    .padding()
  }
}

func sendMessage() {}
