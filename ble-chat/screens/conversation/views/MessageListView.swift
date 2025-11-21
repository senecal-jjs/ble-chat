//
//  MessageListView.swift
//  ble-chat
//
//  Created by Jacob Senecal on 7/11/25.
//

import SwiftUI

struct MessageListView: View {
  let messages: [BleMessage]
  let loggedInUser: String
  let shouldShowParticipantInfo: Bool

  var body: some View {
    ScrollView {
      LazyVStack {
        ForEach(messages) { message in
          VStack {
//            formattedDate(message.createdAt)
//              .font(.caption)
//              .foregroundStyle(.secondary)

            MessageBubbleView(
              message,
              shouldShowParticipantInfo: shouldShowParticipantInfo,
              loggedInUser: loggedInUser
            )
          }
          .padding(.bottom)
        }
      }
      .padding()
    }
    // starts scrolling from the bottom of the list
    .defaultScrollAnchor(.bottom)
  }

  // to learn more checkout https://medium.com/@jpmtech/swiftui-format-dates-and-times-the-easy-way-fc896b25003b
  func formattedDate(_ date: Date) -> some View {
    if date.daysSinceNow < 1 {
      Text("Today \(date.formatted(date: .omitted, time: .shortened))")
    } else if date.daysSinceNow == 1 {
      Text("Yesterday \(date.formatted(date: .omitted, time: .shortened))")
    } else if date.daysSinceNow < 7 {
      Text(
        "\(date.formatted(.dateTime.weekday(.wide))) \(date.formatted(date: .omitted, time: .shortened))"
      )
    } else {
      Text(
        "\(date.formatted(.dateTime.weekday())), \(date.formatted(.dateTime.day().month())) at \(date.formatted(date: .omitted, time: .shortened))"
      )
    }
  }
}

//#Preview {
//  MessageListView(
//    messages: [
//      BleMessage(
//        id: "1", content: "message 1", createdAt: .now.addingTimeInterval(-86400 * 10),
//        sender: "pid1", receiver: "pid2"),
//      BleMessage(
//        id: "2", content: "message 2", createdAt: .now.addingTimeInterval(-86400 * 3),
//        sender: "pid2", receiver: "pid3"),
//      BleMessage(
//        id: "3", content: "message 3", createdAt: .now.addingTimeInterval(-86400 * 1),
//        sender: "pid1", receiver: "pid2"),
//      BleMessage(id: "4", content: "message 4", createdAt: .now, sender: "pid1", receiver: "pid2"),
//      BleMessage(id: "5", content: "message 5", createdAt: .now, sender: "pid2", receiver: "pid1"),
//    ],
//    loggedInUser: "pid1",
//    shouldShowParticipantInfo: true
//  )
//}
