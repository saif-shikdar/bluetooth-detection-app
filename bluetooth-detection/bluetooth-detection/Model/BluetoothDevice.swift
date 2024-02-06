//
//  BluetoothDevice.swift
//  bluetooth-detection
//
//  Created by Saif Shikdar on 06/02/2024.
//

import Foundation
import CoreBluetooth

struct BluetoothDevice {
    let name: String
    let connectionState: CBPeripheralState
}
