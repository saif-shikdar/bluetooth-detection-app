//
//  DeviceListViewModel.swift
//  bluetooth-detection
//
//  Created by Saif Shikdar on 06/02/2024.
//

import Foundation
import CoreBluetooth

class DeviceListViewModel: NSObject, ObservableObject {
    @Published var isBluetoothEnabled = false
    @Published var isScanning = false
    @Published var showErrorMsg = false
    var errorMessage = ""
    
    private var centralManager: CBCentralManager?
    @Published var peripherals: [BluetoothDevice] = []
    
    override init() {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: .main)
    }
    
    func stopScanning() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 8.0) {
            self.centralManager?.stopScan()
            self.isScanning = false
        }
    }
    
    func refreshDeviceList() {
        for device in peripherals where device.isConnected {
            self.centralManager?.cancelPeripheralConnection(device.peripheral)
        }
        startScanning()
    }
    
    func startScanning() {
        guard self.centralManager?.state == .poweredOn else {
            return
        }
        
        peripherals = []
        self.centralManager?.scanForPeripherals(withServices: nil)
        isScanning = true
        stopScanning()
    }
    
    func connectToDevice(peripheral: CBPeripheral) {
        if (peripheral.state == .connected) {
            self.centralManager?.cancelPeripheralConnection(peripheral)
        } else {
            self.centralManager?.connect(peripheral, options: nil)
        }
    }
}

extension DeviceListViewModel: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            isBluetoothEnabled = true
            startScanning()
        default:
            isBluetoothEnabled = false
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if !peripherals.contains(where: {$0.peripheral.identifier == peripheral.identifier}) {
            self.peripherals.append(BluetoothDevice(peripheral: peripheral,
                                                    isConnected: peripheral.state == .connected))
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        for idx in 0..<peripherals.count where peripherals[idx].peripheral.identifier == peripheral.identifier {
            peripherals[idx].isConnected = true
        }
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        if let error = error {
            errorMessage = error.localizedDescription
            showErrorMsg = true
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        if let error = error {
            errorMessage = error.localizedDescription
            showErrorMsg = true
        }
        
        for idx in 0..<peripherals.count where peripherals[idx].peripheral.identifier == peripheral.identifier {
            peripherals[idx].isConnected = false
        }
    }
}
