//
//  ConversationViewModel.swift
//  ble-chat
//
//  Created by Jacob Senecal on 7/11/25.
//

import SwiftUI

class ConversationViewModel: ObservableObject {
  private var peers: [String] = []

  // Published state
  @Published var conversations: [Conversation] = []

  // Services
  private let networkService = NetworkService()
}
