//
//  Conversation.swift
//  ble-chat
//
//  Created by Jacob Senecal on 7/11/25.
//

import Foundation

struct Conversation: Identifiable, Hashable {
  let id: String
  var name: String
  var messages: [BleMessage]
  var participants: [String]
  var lastUpdatedAt: Date
}
