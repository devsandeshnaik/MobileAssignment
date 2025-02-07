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
    @Query() var devices: [DeviceData] = []
    @State private var searchText: String = ""

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                if !newtworkMonitor.isConnected {
                    Color.red.opacity(0.4)
                        .clipShape(Capsule())
                        .padding(.horizontal)
                        .frame(height: 44)
                        .overlay(alignment: .center) {
                            Text("Offline data")
                                .foregroundStyle(.primary)
                        }
                }
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
