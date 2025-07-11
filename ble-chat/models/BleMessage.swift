//
//  BleMessage.swift
//  ble-chat
//
//  Created by Jacob Senecal on 7/11/25.
//

import Foundation

struct BleMessage: Equatable, Codable {
  let id: String
  let content: String
  let createdAt: Date

  init(id: String, content: String, createdAt: Date) {
    self.id = id
    self.content = content
    self.createdAt = createdAt
  }
}
