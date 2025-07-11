//
//  BleMessage.swift
//  ble-chat
//
//  Created by Jacob Senecal on 7/11/25.
//

import Foundation

struct BleMessage: Equatable, Codable, Identifiable, Hashable {
  let id: String
  let content: String
  let createdAt: Date
  let sender: String
  let receiver: String

  init(id: String, content: String, createdAt: Date, sender: String, receiver: String) {
    self.id = id
    self.content = content
    self.createdAt = createdAt
    self.sender = sender
    self.receiver = receiver
  }

  func isMine(userId: String) -> Bool {
    return self.sender == userId
  }
}
