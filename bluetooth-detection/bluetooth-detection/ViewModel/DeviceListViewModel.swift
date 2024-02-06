//
//  DeviceListViewModel.swift
//  bluetooth-detection
//
//  Created by Saif Shikdar on 06/02/2024.
//

import Foundation
import CoreBluetooth

class DeviceListViewModel: NSObject, ObservableObject {
    @Published var isBluetoothEnabled = true
    private var centralManager: CBCentralManager?
    @Published var peripherals: [BluetoothDevice] = [
        BluetoothDevice(name: "Headphones", connectionState: .connected),
        BluetoothDevice(name: "Mouse", connectionState: .connecting),
        BluetoothDevice(name: "Keyboard", connectionState: .disconnected),
        BluetoothDevice(name: "Controller", connectionState: .disconnecting)
    ]
    
    override init() {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: .main)
    }
}

extension DeviceListViewModel: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            self.centralManager?.scanForPeripherals(withServices: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        let bluetoothDevice = BluetoothDevice(name: peripheral.name ?? "Unknown Device",
                                              connectionState: peripheral.state)
        if !peripherals.contains(where: {$0.name == bluetoothDevice.name}) {
            self.peripherals.append(bluetoothDevice)
        }
    }
}
