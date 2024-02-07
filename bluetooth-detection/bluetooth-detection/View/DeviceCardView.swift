//
//  DeviceCardView.swift
//  bluetooth-detection
//
//  Created by Saif Shikdar on 07/02/2024.
//

import SwiftUI
import CoreBluetooth

struct DeviceCardView: View {
    let device: BluetoothDevice?
    
    var body: some View {
        HStack {
            Text(device?.peripheral.name ?? "Unknown Device")
            Spacer()
            switch device?.connectionStatus {
            case .connected:
                createConnectionIndicator(color: .green)
            case .disconnected:
                createConnectionIndicator(color: .red)
            case .loading:
                createConnectionIndicator(color: nil)
            case .none:
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
    DeviceCardView(device: nil)
        .previewLayout(.sizeThatFits)
}
