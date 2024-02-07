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
                if viewModel.isScanning {
                    ProgressView()
                } else {
                    Button("Refresh", systemImage: "arrow.triangle.2.circlepath.circle") {
                        viewModel.refreshDeviceList()
                    }
                }
            }
            Text("Device List")
                .bold()
            Divider()
            List(viewModel.peripherals, id: \.peripheral.identifier) { device in
                Button {
                    viewModel.connectToDevice(peripheral: device.peripheral)
                } label: {
                    createDeviceCardView(device: device)
                }
            }
            Spacer()
        }
        .alert(viewModel.errorMessage, isPresented: $viewModel.showErrorMsg) {
            Button("OK", role: .cancel) {}
        }
        .padding()
    }
    
    @ViewBuilder
    func createDeviceCardView(device: BluetoothDevice) -> some View {
        HStack {
            Text(device.peripheral.name ?? "Unknown Device")
            Spacer()
            switch device.connectionStatus {
            case .connected:
                createConnectionIndicator(color: .green)
            case .disconnected:
                createConnectionIndicator(color: .red)
            case .loading:
                createConnectionIndicator(color: nil)
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
