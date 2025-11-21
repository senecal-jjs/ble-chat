//
//  CBPeripheralDelegate.swift
//  ble-chat
//
//  Created by Jacob Senecal on 7/11/25.
//

import CoreBluetooth

extension NetworkService: CBPeripheralDelegate {

  // The peripheral letting us know when services have been invalidated
  func peripheral(_ peripheral: CBPeripheral, didModifyServices invalidatedServices: [CBService]) {
    for service in invalidatedServices where service.uuid == NetworkService.serviceId {
      print("Transfer service is invalidated, re-discover services")
      peripheral.discoverServices([NetworkService.serviceId])
    }
  }

  // The network service was discovered
  func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: (any Error)?) {
    if let error = error {
      print("Error discovering services: \(error.localizedDescription)")
      cleanup(peripheral)
      return
    }

    // Find the characteristic we want
    // Loop over the newly filled peripheral.services, in case there's more than one
    guard let peripheralServices = peripheral.services else { return }

    for service in peripheralServices {
      peripheral.discoverCharacteristics([NetworkService.characteristicId], for: service)
    }
  }

  // Found the transfer characteristic
  // Subscribe, which lets the peripheral know we want the data contained in the characteristic
  func peripheral(
    _ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService,
    error: (any Error)?
  ) {
    if let error = error {
      print("Error discovering characteristics: \(error.localizedDescription)")
      cleanup(peripheral)
      return
    }

    guard let characteristics = service.characteristics else { return }

    for characteristic in characteristics
    where characteristic.uuid == NetworkService.characteristicId {
      peripheralCharacteristics[peripheral] = characteristic

      peripheral.setNotifyValue(true, for: characteristic)

      // Request maximum MTU for faster data transfer
      // iOS supports up to 512 bytes with BLE 5.0
      peripheral.maximumWriteValueLength(for: .withoutResponse)
    }

    // now wait for data to arrive
  }

  // Data has arrived on the characteristic
  func peripheral(
    _ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic,
    error: (any Error)?
  ) {

    guard let data = characteristic.value else {
      return
    }

    guard let packet = BlePacket.from(data) else {
      // Failed to parse packet
      return
    }

    // TODO(handle packet)

    print("Received data: \(String(data: characteristic.value!, encoding: .utf8) ?? "No data")")

  }

  func peripheral(
    _ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?
  ) {
    if let error = error {
      // Log error but don't spam for common errors
      let errorCode = (error as NSError).code
      if errorCode != 242 {  // Don't log the common "Unknown ATT error"
        // print("[ERROR] Write failed: \(error)")
      }
    } else {
    }
  }

  // The peripheral letting us know if our subscribe/unsubcribe happened
  func peripheral(
    _ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic,
    error: (any Error)?
  ) {
    if let error = error {
      print("Error changing notification state: \(error.localizedDescription)")
      return
    }

    // exit if it's not the transfer characteristic
    guard characteristic.uuid == NetworkService.characteristicId else { return }

    if characteristic.isNotifying {
      // Notification has started
      print("Notification began on \(characteristic)")
    } else {
      // Notification has stopped, so disconnect from the peripheral
      print("Notification stopped on \(characteristic). Disconnecting.")
      cleanup(peripheral)
    }
  }

  func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: (any Error)?) {
    guard error == nil else { return }

    // find the peer id for this peripheral
  }
}
