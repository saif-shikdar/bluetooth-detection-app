//
//  BluetoothDevice.swift
//  bluetooth-detection
//
//  Created by Saif Shikdar on 07/02/2024.
//

import Foundation
import CoreBluetooth

enum BluetoothConnectionStatus {
    case connected
    case disconnected
    case loading
}

struct BluetoothDevice {
    let peripheral: CBPeripheral
    var connectionStatus: BluetoothConnectionStatus
}
