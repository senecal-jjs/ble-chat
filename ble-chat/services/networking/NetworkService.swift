//
//  NetworkService.swift
//  ble-chat
//
//  Created by Jacob Senecal on 7/11/25.
//

import CoreBluetooth
import Foundation

class NetworkService: NSObject {
  // Bluetooth
  static let serviceId: CBUUID = CBUUID(string: "63fd27ba-a896-4779-aaf2-0d5b1f287a79")
  static let characteristicId: CBUUID = CBUUID(string: "140e65f6-fbdd-455a-8e8e-0aa8959b9351")

  var service: CBMutableService!
  var characteristic: CBMutableCharacteristic!
  var centralManager: CBCentralManager?
  var peripheralManager: CBPeripheralManager?

  var connectedPeripherals: [CBPeripheral] = []
  var discoveredPeripherals: [CBPeripheral] = []
  var peripheralCharacteristics: [CBPeripheral: CBCharacteristic] = [:]
  var subscribedCentrals: [CBCentral] = []

  // ephemeral, makes tracking of users harder
  var userId: String = generateRandomBytes(size: 8)!
  var settings: AppSettings? = nil

  override init() {
    super.init()

    centralManager = CBCentralManager(delegate: self, queue: nil)
    peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
  }

  func populateSettings(settings: AppSettings) {
    self.settings = settings
  }

  func sendBroadcastAnnounce() {
    // Announce nickname, peer id -> nickname changes every session
  }

  // ========================= Start Peripheral Management =======================
  // peripheral advertises data in chunks on the transfer characteristic
  // central receives data in chunks until end of packet marker
  //
  // BleMessage -> BinaryData -> inserted as payload in packet -> packet passed to fragmenter which split single packet into multiple

  private func broadcastPacket(_ packet: Packet) {
    // send to connected peripherals (as central)
    // write to the peripherals characteristic

    // send to subscribed centrals (as peripheral)
    // write to my characteristic
  }

  /*
   *  Call this when things either go wrong, or you're done with the connection.
   *  This cancels any subscriptions if there are any, or straight disconnects if not.
   *  (didUpdateNotificationStateForCharacteristic will cancel the connection if a subscription is involved)
   */
  func cleanup(_ discoveredPeripheral: CBPeripheral?) {
    // Don't do anything if we're not connected
    guard let discoveredPeripheral = discoveredPeripheral,
      case .connected = discoveredPeripheral.state
    else { return }

    for service in (discoveredPeripheral.services ?? [] as [CBService]) {
      for characteristic in (service.characteristics ?? [] as [CBCharacteristic]) {
        if characteristic.uuid == NetworkService.characteristicId && characteristic.isNotifying {
          // It is notifying, so unsubscribe
          discoveredPeripheral.setNotifyValue(false, for: characteristic)
        }
      }
    }

    // If we've gotten this far, we're connected, but we're not subscribed, so we just disconnect
    centralManager?.cancelPeripheralConnection(discoveredPeripheral)
  }

}
