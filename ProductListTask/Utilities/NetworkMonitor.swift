//
//  NetworkMonitor.swift
//  ProductListTask
//
//  Created by sherif on 11/05/2025.
//

import Network
import Foundation


class NetworkMonitor {
    
    static let shared = NetworkMonitor()
    
    private let monitor: NWPathMonitor
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    var isConnected: Bool = false
    var onNetworkStatusChanged: ((Bool) -> Void)?
    
    private init() {
        monitor = NWPathMonitor()
        startMonitoring()
    }
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            let isConnected = path.status == .satisfied
            self?.isConnected = isConnected
            DispatchQueue.main.async {
                self?.onNetworkStatusChanged?(isConnected)
                print("Network status changed: \(isConnected ? "Connected" : "Disconnected")")
            }
        }
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}
