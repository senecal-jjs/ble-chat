//
//  BleMessage.swift
//  ble-chat
//
//  Created by Jacob Senecal on 7/11/25.
//

import Foundation

struct BleMessage: Codable, Equatable, Hashable {
  let id: String
  let sender: String
  let content: String
  let timestamp: Date
  let isRelay: Bool
  let originalSender: String?
  let isPrivate: Bool
  let recipientNickname: String?
  let senderPeerID: String?
  let mentions: [String]?  // Array of mentioned nicknames
  let channel: String?  // Channel hashtag (e.g., "#general")
  let encryptedContent: Data?  // For password-protected rooms
  let isEncrypted: Bool  // Flag to indicate if content is encrypted
  var deliveryStatus: DeliveryStatus?  // Delivery tracking

  init(
    id: String? = nil,
    sender: String,
    content: String,
    timestamp: Date,
    isRelay: Bool,
    originalSender: String? = nil,
    isPrivate: Bool = false,
    recipientNickname: String? = nil,
    senderPeerID: String? = nil,
    mentions: [String]? = nil,
    channel: String? = nil,
    encryptedContent: Data? = nil,
    isEncrypted: Bool = false,
    deliveryStatus: DeliveryStatus? = nil
  ) {
    self.id = id ?? UUID().uuidString
    self.sender = sender
    self.content = content
    self.timestamp = timestamp
    self.isRelay = isRelay
    self.originalSender = originalSender
    self.isPrivate = isPrivate
    self.recipientNickname = recipientNickname
    self.senderPeerID = senderPeerID
    self.mentions = mentions
    self.channel = channel
    self.encryptedContent = encryptedContent
    self.isEncrypted = isEncrypted
    self.deliveryStatus = deliveryStatus ?? (isPrivate ? .sending : nil)
  }
}
