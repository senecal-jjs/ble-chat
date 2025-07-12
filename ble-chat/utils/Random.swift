//
//  Random.swift
//  ble-chat
//
//  Created by Jacob Senecal on 7/11/25.
//

import Foundation

func generateRandomBytes(size: Int) -> String? {
  var keyData = Data(count: size)
  let result = keyData.withUnsafeMutableBytes {
    SecRandomCopyBytes(kSecRandomDefault, size, $0.baseAddress!)
  }
  if result == errSecSuccess {
    return keyData.base64EncodedString()
  } else {
    print("Error generating random bytes")
    return nil
  }
}
