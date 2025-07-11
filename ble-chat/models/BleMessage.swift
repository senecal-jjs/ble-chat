//
//  BleMessage.swift
//  ble-chat
//
//  Created by Jacob Senecal on 7/11/25.
//

struct BleMessage: Equatable, Codable {
    let id: String
    let content: String
}
