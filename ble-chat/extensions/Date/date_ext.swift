//
//  date_ext.swift
//  ble-chat
//
//  Created by Jacob Senecal on 7/11/25.
//

import Foundation

extension Date {
  var daysSinceNow: Int {
    Calendar.current.dateComponents([.day], from: self, to: Date.now).day ?? 0
  }
}
