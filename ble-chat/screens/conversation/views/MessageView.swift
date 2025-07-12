//
//  MessageView.swift
//  ble-chat
//
//  Created by Jacob Senecal on 7/11/25.
//

import SwiftUI

struct MessageView: View {
  var message: BleMessage
  var viewerId: String

  var body: some View {
    let isMine = message.isMine(userId: viewerId)

    VStack {
      Text(message.createdAt.ISO8601Format())
        .fontWeight(.light)
        .font(.footnote)

      HStack(alignment: .bottom, spacing: 10) {
        if !isMine {
          Image(systemName: "person.circle.fill")
            .resizable()
            .frame(width: 40, height: 40, alignment: .center)
            .cornerRadius(20)
        } else {
          Spacer()
        }

        Text(message.content)
          .padding(10)
          .foregroundColor(.white)
          .background(isMine ? .blue : .gray)
          .cornerRadius(10)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding()
    }
  }
}
