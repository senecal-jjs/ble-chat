//
//  MessageComposerView.swift
//  ble-chat
//
//  Created by Jacob Senecal on 7/11/25.
//

import SwiftUI

struct MessageComposerView: View {
  @Binding var messageText: String

  var body: some View {
    HStack(alignment: .bottom) {
      TextField("Message Input", text: $messageText, prompt: Text("Message"), axis: .vertical)
        .padding(4)
        .overlay {
          Rectangle()
            .fill(.clear)
            .roundedCornerWithBorder(
              borderColor: .secondary,
              radius: 8,
              corners: .allCorners
            )
        }

      if messageText.isEmpty {
        EmptyView()
      } else {
        Button {
          // send message
        } label: {
          Image(systemName: "arrow.up.circle.fill")
            .imageScale(.large)
        }
      }
    }
  }
}

#Preview {
  MessageComposerView(
    messageText: .constant(""),
  )
}
