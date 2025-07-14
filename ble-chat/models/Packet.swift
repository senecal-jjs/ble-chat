//
//  Packet.swift
//  ble-chat
//
//  Created by Jacob Senecal on 7/11/25.
//

import CryptoKit
import Foundation

struct Packet: Codable {
  let version: UInt8
  let type: UInt8
  let senderID: Data
  let recipientID: Data?
  let timestamp: UInt64
  let payload: Data
  let signature: Data?
  var ttl: UInt8

  init(
    type: UInt8, senderID: Data, recipientID: Data?, timestamp: UInt64, payload: Data,
    signature: Data?, ttl: UInt8
  ) {
    self.version = 1
    self.type = type
    self.senderID = senderID
    self.recipientID = recipientID
    self.timestamp = timestamp
    self.payload = payload
    self.signature = signature
    self.ttl = ttl
  }

  // Convenience initializer for new binary format
  init(type: UInt8, ttl: UInt8, senderID: String, payload: Data) {
    self.version = 1
    self.type = type
    self.senderID = senderID.data(using: .utf8)!
    self.recipientID = nil
    self.timestamp = UInt64(Date().timeIntervalSince1970 * 1000)  // milliseconds
    self.payload = payload
    self.signature = nil
    self.ttl = ttl
  }

  var data: Data? {
    BinaryProtocol.encode(self)
  }

  func toBinaryData() -> Data? {
    BinaryProtocol.encode(self)
  }

  static func from(_ data: Data) -> BitchatPacket? {
    BinaryProtocol.decode(data)
  }
}
