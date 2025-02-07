//
//  AssignmentApp.swift
//  Assignment
//
//  Created by Kunal on 03/01/25.
//

import SwiftUI
import SwiftData

@main
struct AssignmentApp: App {
    
    @State private var networkMonitor = NetworkMonitor()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(networkMonitor)
        }
        .modelContainer(for: DeviceData.self)
        
    }
}
