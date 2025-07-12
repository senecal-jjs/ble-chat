//
//  CBPeripheralDelegate.swift
//  ble-chat
//
//  Created by Jacob Senecal on 7/11/25.
//

import CoreBluetooth

extension NetworkService: CBPeripheralDelegate {
  func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
    if peripheral.state == .poweredOn {
      print("Peripheral Manager is powered on")

      let peripheralService = setupServicesAndCharacteristics(
        peripheral,
        peerId: self.userId,
      )

      peripheral.add(peripheralService)

      peripheral.startAdvertising([
        CBAdvertisementDataServiceUUIDsKey: [peripheralService.uuid],
        CBAdvertisementDataLocalNameKey: self.userId,
      ])
    } else {
      print("Peripheral Manager is not powered on")
    }
  }

  func setupServicesAndCharacteristics(
    _ peripheral: CBPeripheralManager,
    peerId: String,
  ) -> CBMutableService {
    // Create a characteristic
    let myCharacteristic = CBMutableCharacteristic(
      type: NetworkService.characteristicId,
      properties: [.read, .write, .notify, .writeWithoutResponse],  // Example properties: read, write, notify
      value: nil,
      permissions: [.readable, .writeable]  // Example permissions
    )

    // Create a service and add the characteristic
    let myService = CBMutableService(type: NetworkService.serviceId, primary: true)
    myService.characteristics = [myCharacteristic]

    return myService
  }
}
