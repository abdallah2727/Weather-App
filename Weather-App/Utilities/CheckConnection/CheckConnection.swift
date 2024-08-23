//
//  CheckConnection.swift
//  Weather-App
//
//  Created by Abdallah ismail on 22/08/2024.
//

import Foundation
import Reachability

class CheckConnection {
    static let shared = CheckConnection()
    private var reachability: Reachability?

      private init() {
          setupReachability()
      }

      private func setupReachability() {
          do {
              reachability = try Reachability()
              reachability?.whenReachable = { reachability in
                  if reachability.connection == .wifi {
                      print("Reachable via WiFi")
                  } else if reachability.connection == .cellular {
                      print("Reachable via Cellular")
                  }
              }
              reachability?.whenUnreachable = { _ in
                  print("Not reachable")
              }

              try reachability?.startNotifier()
          } catch {
              print("Unable to start notifier")
          }
      }

      func isNetworkAvailable() -> Bool {
          return reachability?.connection != .unavailable
      }
}
