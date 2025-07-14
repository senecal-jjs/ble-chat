//
//  PacketHandler.swift
//  ble-chat
//
//  Created by Jacob Senecal on 7/12/25.
//

import CoreBluetooth

struct PacketHandler {
  func handleReceivedPacket(_ packet: Packet, from peerId: String, peripheral: CBPeripheral? = nil)
  {
    switch MessageType(rawValue: packet.type) {
    case .message:
    case .announce:
    case .deliveryAck:
    case .deliveryStatusRequest:
    case .fragment_start:
    case .fragment_continue:
    case .fragment_end:
    case .key_exchange:
    case .leave:
    case .readReceipt:
    default:
      break
    }
  }
}
