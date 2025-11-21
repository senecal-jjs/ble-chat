//
//  Packet.swift
//  ble-chat
//
//  Created by Jacob Senecal on 7/11/25.
//

import Foundation

/// The core packet structure for all BitChat protocol messages.
/// Encapsulates all data needed for routing through the mesh network,
/// including TTL for hop limiting and optional encryption.
/// - Note: Packets larger than BLE MTU (512 bytes) are automatically fragmented
struct BlePacket: Codable {
    let version: UInt8
    let type: UInt8
    let senderID: String
    let recipientID: String?
    let timestamp: UInt64
    let payload: Data
    var signature: Data?
    var ttl: UInt8
    var route: [Data]?
    
    init(type: UInt8, senderID: String, recipientID: String?, timestamp: UInt64, payload: Data, signature: Data?, ttl: UInt8, version: UInt8 = 1, route: [Data]? = nil) {
        self.version = version
        self.type = type
        self.senderID = senderID
        self.recipientID = recipientID
        self.timestamp = timestamp
        self.payload = payload
        self.signature = signature
        self.ttl = ttl
        self.route = route
    }
    
    // Convenience initializer for new binary format
    init(type: UInt8, ttl: UInt8, senderID: String, payload: Data) {
        self.version = 1
        self.type = type
        self.senderID = senderID
        self.recipientID = nil
        self.timestamp = UInt64(Date().timeIntervalSince1970 * 1000) // milliseconds
        self.payload = payload
        self.signature = nil
        self.ttl = ttl
        self.route = nil
    }
    
    var data: Data? {
        BinaryProtocol.encode(self)
    }
    
    func toBinaryData(padding: Bool = true) -> Data? {
        BinaryProtocol.encode(self, padding: padding)
    }

    // Backward-compatible helper (defaults to padded encoding)
    func toBinaryData() -> Data? {
        toBinaryData(padding: true)
    }
    
    /// Create binary representation for signing (without signature and TTL fields)
    /// TTL is excluded because it changes during packet relay operations
    func toBinaryDataForSigning() -> Data? {
        // Create a copy without signature and with fixed TTL for signing
        // TTL must be excluded because it changes during relay
        let unsignedPacket = BlePacket(
            type: type,
            senderID: senderID,
            recipientID: recipientID,
            timestamp: timestamp,
            payload: payload,
            signature: nil, // Remove signature for signing
            ttl: 0, // Use fixed TTL=0 for signing to ensure relay compatibility
            version: version,
            route: route
        )
        return BinaryProtocol.encode(unsignedPacket)
    }
    
    static func from(_ data: Data) -> BlePacket? {
        BinaryProtocol.decode(data)
    }
}
