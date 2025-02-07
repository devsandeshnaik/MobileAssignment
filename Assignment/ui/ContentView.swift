//
//  ContentView.swift
//  Assignment
//
//  Created by Kunal on 03/01/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) var context
    @Environment(NetworkMonitor.self) private var newtworkMonitor
    
    @ObservedObject var viewModel = ContentViewModel()
    @State private var path: [DeviceData] = [] // Navigation path
    @Query(sort: []) var devices: [DeviceData] = []
    @State private var searchText: String = ""

    var body: some View {
        NavigationStack(path: $path) {
            Group {
                if let computers = viewModel.data, !computers.isEmpty {
                    DevicesList(devices: deviceList) { selectedComputer in
                        viewModel.navigateToDetail(navigateDetail: selectedComputer)
                    }
                } else {
                    ProgressView("Loading...")
                }
            }
            .onChange(of: viewModel.navigateDetail, {
                let navigate = viewModel.navigateDetail
                path.append(navigate!)
            })
            .navigationTitle("Devices")
            .navigationDestination(for: DeviceData.self) { computer in
                DetailView(device: computer)
            }
            .onAppear {
                viewModel.fetchAPI()
//                let navigate = viewModel.navigateDetail
//                if (navigate != nil) {
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                        path.append(navigate!)
//                    }
//                }
            }
        }
        .onReceive(viewModel.$data) { data in
            guard let deviceData = data, !deviceData.isEmpty else {
                return
            }
            for device in deviceData {
                 context.insert(device)
            }
            try? context.save()
        }
        .searchable(text: $searchText)
    }
    
    var deviceList: [DeviceData] {
        if newtworkMonitor.isConnected {
            guard let data = viewModel.data else {
                return []
            }
            return data.filter { $0.name.hasPrefix(searchText)}
        } else {
            return devices.filter { $0.name.hasPrefix(searchText)}
        }
    }
    
}
