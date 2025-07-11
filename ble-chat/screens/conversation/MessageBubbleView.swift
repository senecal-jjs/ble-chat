//
//  MessageBubbleView.swift
//  ble-chat
//
//  Created by Jacob Senecal on 7/11/25.
//

import SwiftUI

struct MessageBubbleView: View {
  let message: BleMessage
  let shouldShowParticipantInfo: Bool
  let loggedInUser: String

  init(_ message: BleMessage, shouldShowParticipantInfo: Bool, loggedInUser: String) {
    self.message = message
    self.shouldShowParticipantInfo = shouldShowParticipantInfo
    self.loggedInUser = loggedInUser
  }

  var body: some View {
    let isMine = message.isMine(userId: loggedInUser)

    HStack(alignment: .bottom, spacing: 0) {
      if isMine {
        Spacer()
      }

      if shouldShowParticipantInfo && !isMine {
        Image(systemName: "person.circle.fill")
          .resizable()
          .frame(width: 40, height: 40, alignment: .center)
          .cornerRadius(20)
      }

      VStack(alignment: .leading, spacing: 4) {
        if shouldShowParticipantInfo && !isMine {
          Text(message.sender)
            .font(.caption)
            .foregroundStyle(.secondary)
            .padding(.leading)
        }

        Text(message.content)
          .messageBubbleStyle(isFromYou: isMine)
      }

      if !isMine {
        Spacer()
      }
    }
  }
}

#Preview {
  VStack {
    MessageBubbleView(
      BleMessage(
        id: "1", content: "message 1", createdAt: Date.now, sender: "pid1", receiver: "pid2"),
      shouldShowParticipantInfo: true,
      loggedInUser: "pid1"
    )
    MessageBubbleView(
      BleMessage(
        id: "2", content: "message 2", createdAt: Date.now, sender: "pid2", receiver: "pid3"),
      shouldShowParticipantInfo: true,
      loggedInUser: "pid1"
    )
    MessageBubbleView(
      BleMessage(
        id: "3", content: "message 3", createdAt: Date.now, sender: "pid1", receiver: "pid2"),
      shouldShowParticipantInfo: false,
      loggedInUser: "pid1"
    )
  }
}
