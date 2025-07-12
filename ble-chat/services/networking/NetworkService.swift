//
//  NetworkService.swift
//  ble-chat
//
//  Created by Jacob Senecal on 7/11/25.
//

import CoreBluetooth
import Foundation

class NetworkService: NSObject {
  static let serviceId: CBUUID = CBUUID(string: "63fd27ba-a896-4779-aaf2-0d5b1f287a79")
  static let characteristicId: CBUUID = CBUUID(string: "140e65f6-fbdd-455a-8e8e-0aa8959b9351")

  // Bluetooth
  var service: CBMutableService!
  var characteristic: CBMutableCharacteristic!
  var centralManager: CBCentralManager?
  var peripheralMananger: CBPeripheralManager?

  // ephemeral, makes tracking of users harder
  var userId: String = generateRandomBytes(size: 8)!
  var connectedPeripherals: [CBPeripheral] = []
  var discoveredPeripherals: [CBPeripheral] = []
  var settings: AppSettings? = nil

  override init() {
    super.init()

    centralManager = CBCentralManager(delegate: self, queue: nil)
    peripheralMananger = CBPeripheralManager(delegate: self, queue: nil)
  }

  func populateSettings(settings: AppSettings) {
    self.settings = settings
  }

  // ========================= Start Peripheral Management =======================

}
