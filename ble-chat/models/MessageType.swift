//
//  MessageType.swift
//  ble-chat
//
//  Created by Jacob Senecal on 7/11/25.
//

enum MessageType: UInt8 {
  case announce = 0x01
  case key_exchange = 0x02
  case leave = 0x03
  case message = 0x04
  case fragment_start = 0x05
  case fragment_continue = 0x06
  case fragment_end = 0x07
  case deliveryAck = 0x0A  // Acknowledge message received
  case deliveryStatusRequest = 0x0B  // Request delivery status update
  case readReceipt = 0x0C  // Message has been read/viewed
}
