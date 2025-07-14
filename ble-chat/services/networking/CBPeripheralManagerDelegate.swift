//
//  CBPeripheralManagerDelegate.swift
//  ble-chat
//
//  Created by Jacob Senecal on 7/11/25.
//

import CoreBluetooth

extension NetworkService: CBPeripheralManagerDelegate {

  func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
    if peripheral.state == .poweredOn {
      print("Peripheral Manager is powered on")

      setupServicesAndCharacteristics()
      setupAdvertising()

      // Send announces when peripheral manager is ready
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
        self?.sendBroadcastAnnounce()
      }
    } else {
      print("Peripheral Manager is not powered on")
    }
  }

  func peripheralManager(
    _ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]
  ) {
    for request in requests {
      if let data = request.value, let packet = Packet.from(data) {
        // try to identify peer from packet

        // store the central for updates

        // track this peer as connected, if unknown and send announce if message is key exchange

        // handle received packet

        peripheral.respond(to: request, withResult: .success)
      }
    }
  }

  func peripheralManager(
    _ peripheral: CBPeripheralManager, central: CBCentral,
    didSubscribeTo characteristic: CBCharacteristic
  ) {
    if !subscribedCentrals.contains(central) {
      subscribedCentrals.append(central)

      // send key exchange

    }
  }

  func peripheralManager(
    _ peripheral: CBPeripheralManager, central: CBCentral,
    didUnsubscribeFrom characteristic: CBCharacteristic
  ) {
    subscribedCentrals.removeAll { $0 == central }

    // ensure advertising continues for reconnection
    if peripheralManager?.state == .poweredOn && peripheralManager?.isAdvertising == false {
      setupAdvertising()
    }
  }

  private func setupAdvertising() {
    guard peripheralManager?.state == .poweredOn else {
      return
    }

    peripheralManager?.startAdvertising([
      CBAdvertisementDataServiceUUIDsKey: [NetworkService.serviceId],
      // use only peer id without any identifying prefix
      CBAdvertisementDataLocalNameKey: self.userId,
    ])
  }

  private func setupServicesAndCharacteristics() {
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

    self.characteristic = myCharacteristic
    self.peripheralManager?.add(myService)
  }
}
