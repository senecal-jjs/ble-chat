//
//  CBCentralManagerDelegate.swift
//  ble-chat
//
//  Created by Jacob Senecal on 7/11/25.
//

import CoreBluetooth

extension NetworkService: CBCentralManagerDelegate {

  func centralManagerDidUpdateState(_ central: CBCentralManager) {
    if central.state == CBManagerState.poweredOn {
      print("BLE powered on")
      central.scanForPeripherals(
        withServices: [NetworkService.serviceId],
        options: [CBCentralManagerScanOptionAllowDuplicatesKey: true]
      )

    } else {
      print("Something wrong with BLE")
    }
  }

  func centralManager(
    _ central: CBCentralManager,
    didDiscover peripheral: CBPeripheral,
    advertisementData: [String: Any],
    rssi RSSI: NSNumber
  ) {
    //        print("[BLUETOOTH DEBUG] Discovered peripheral: \(peripheral.name ?? "Unknown") ID: \(peripheral.identifier) RSSI: \(RSSI.intValue)")

    // don't connect if signal is weak
    guard RSSI.intValue > -100 else {
      print("[BLUETOOTH DEBUG] Ignoring peripheral due to very weak signal")
      return
    }

    // newly discovered device
    if !discoveredPeripherals.contains(peripheral) {
      discoveredPeripherals.append(peripheral)

      peripheral.delegate = self

      // attempt connection
      self.centralManager?.connect(
        peripheral,
        options: [
          CBConnectPeripheralOptionNotifyOnConnectionKey: true,
          CBConnectPeripheralOptionNotifyOnDisconnectionKey: true,
          CBConnectPeripheralOptionNotifyOnNotificationKey: true,
        ]
      )
    }
  }

  func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
    // connection success
    connectedPeripherals.append(peripheral)
  }
}
