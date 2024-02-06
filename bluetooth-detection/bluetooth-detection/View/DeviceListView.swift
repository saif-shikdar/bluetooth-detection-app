//
//  DeviceListView.swift
//  bluetooth-detection
//
//  Created by Saif Shikdar on 06/02/2024.
//

import SwiftUI
import CoreBluetooth

struct DeviceListView: View {
    @ObservedObject var viewModel: DeviceListViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            HStack {
                Text("Bluetooth Enabled: ")
                Text(viewModel.isBluetoothEnabled ? "ON" : "OFF")
                    .foregroundStyle(viewModel.isBluetoothEnabled ? .green : .red)
                    .bold()
                Spacer()
                Button("Refresh", systemImage: "arrow.triangle.2.circlepath.circle") {
                    print("Refreshing device list...")
                }
            }
            Text("Device List")
                .bold()
            Divider()
            List(viewModel.peripherals, id: \.name) { device in
                createDeviceCardView(name: device.name, 
                                     connectionState: device.connectionState)
            }
            Spacer()
        }
        .padding()
    }
    
    @ViewBuilder
    func createDeviceCardView(name: String?, 
                              connectionState: CBPeripheralState) -> some View {
        HStack {
            Text(name ?? "Unknown Device")
            Spacer()
            switch connectionState {
            case .disconnected:
                createConnectionIndicator(color: .red)
            case .connecting:
                createConnectionIndicator(color: nil)
            case .connected:
                createConnectionIndicator(color: .green)
            case .disconnecting:
                createConnectionIndicator(color: nil)
            @unknown default:
                createConnectionIndicator(color: .red)
            }
        }
    }
    
    @ViewBuilder
    func createConnectionIndicator(color: Color?) -> some View {
        if color == nil {
            ProgressView()
                .scaleEffect(0.7)
        } else {
            Circle()
                .fill(color ?? .red)
                .frame(width: 10, height: 10)
                .padding(.trailing, 5)
        }
    }
}

#Preview {
    DeviceListView(viewModel: DeviceListViewModel())
}
