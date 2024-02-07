//
//  DeviceListView.swift
//  bluetooth-detection
//
//  Created by Saif Shikdar on 06/02/2024.
//

import SwiftUI
import CoreBluetooth

struct DeviceListView: View {
    @StateObject var viewModel: DeviceListViewModel
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 15) {
                createHeaderView()
                List(viewModel.peripherals, id: \.peripheral.identifier) { device in
                    Button {
                        viewModel.connectToDevice(peripheral: device.peripheral)
                    } label: {
                        DeviceCardView(device: device)
                    }
                }
            }
            .navigationTitle("Device List")
            .navigationBarTitleDisplayMode(.inline)
            .alert(viewModel.errorMessage, 
                   isPresented: $viewModel.showErrorMsg) {
                Button("OK", role: .cancel) {}
            }
        .padding()
        }
    }
    
    @ViewBuilder
    func createHeaderView() -> some View {
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
        Divider()
    }
}

#Preview {
    DeviceListView(viewModel: DeviceListViewModel())
}
