//
//  BluetoothDevice.swift
//  bluetooth-detection
//
//  Created by Saif Shikdar on 07/02/2024.
//

import Foundation
import CoreBluetooth

struct BluetoothDevice {
    let peripheral: CBPeripheral
    var isConnected: Bool
}
