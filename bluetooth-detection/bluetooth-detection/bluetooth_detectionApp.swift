//
//  bluetooth_detectionApp.swift
//  bluetooth-detection
//
//  Created by Saif Shikdar on 06/02/2024.
//

import SwiftUI

@main
struct bluetooth_detectionApp: App {
    var body: some Scene {
        WindowGroup {
            DeviceListView(viewModel: DeviceListViewModel())
        }
    }
}
