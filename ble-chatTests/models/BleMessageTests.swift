//
//  BleMessageTests.swift
//  ble-chat
//
//  Created by Jacob Senecal on 11/21/25.
//

import Foundation
import Testing
@testable import ble_chat

struct modelsTests {

    @Test func encodeDecodeMessage() async throws {
      let message = BleMessage(
        id: "1",
        sender: "bob",
        content: "hello",
        timestamp: Date(),
        isRelay: false,
        originalSender: nil,
        isPrivate: false,
        recipientNickname: "ace",
        senderPeerID: "123",
        mentions: nil,
        deliveryStatus: nil,
      )
      
      let encoded = message.toBinaryPayload()!
      let decoded = BleMessage(encoded)!
      
      #expect(decoded.id == message.id)
      #expect(decoded.sender == message.sender)
      #expect(decoded.content == message.content)
      #expect(decoded.isRelay == message.isRelay)
      #expect(decoded.originalSender == message.originalSender)
      #expect(decoded.isPrivate == message.isPrivate)
      #expect(decoded.recipientNickname == message.recipientNickname)
      #expect(decoded.senderPeerID == message.senderPeerID)
      #expect(decoded.mentions == message.mentions)
    }

  @Test func encodeDecodePacket() async throws {
    let message = BleMessage(
      id: "1",
      sender: "bob",
      content: "hello",
      timestamp: Date(),
      isRelay: false,
      originalSender: nil,
      isPrivate: false,
      recipientNickname: "ace",
      senderPeerID: "123",
      mentions: nil,
      deliveryStatus: DeliveryStatus.sending,
    )
    
    let encoded = message.toBinaryPayload()!
    
    let packet = BlePacket(
      type: MessageType.announce.rawValue,
      ttl: 3,
      senderID: "1",
      payload: encoded,
    )
    
    let encodedPacket = packet.toBinaryData()!
    let decodedPacket = BlePacket.from(encodedPacket)!
    let decoded = BleMessage(decodedPacket.payload)!
    
    #expect(decoded.id == message.id)
    #expect(decoded.sender == message.sender)
    #expect(decoded.content == message.content)
    #expect(decoded.isRelay == message.isRelay)
    #expect(decoded.originalSender == message.originalSender)
    #expect(decoded.isPrivate == message.isPrivate)
    #expect(decoded.recipientNickname == message.recipientNickname)
    #expect(decoded.senderPeerID == message.senderPeerID)
    #expect(decoded.mentions == message.mentions)
  }
}

