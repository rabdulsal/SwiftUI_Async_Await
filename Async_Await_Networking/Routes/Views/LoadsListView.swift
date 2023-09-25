//
//  LoadsListView.swift
//  Async_Await_Networking
//
//  Created by Rashad Abdul-Salaam on 9/19/23.
//

import SwiftUI

class LoadsListViewModel: ObservableObject {
    @Published var loads = [LoadItem]()
    @Published var loadsFetchError = ""
    
    private var networkingService = LoadsNetworkingService()
    
    func getLoadsList(pageSize: Int = 10) async {
        do {
            let result = try await self.networkingService.getLoads()
            
            switch result {
            case .success(let loadsList):
                DispatchQueue.main.async {
                    self.loads = loadsList.data
                }
            case .failure(let error): throw error
            }
        } catch {
            self.loadsFetchError = error.localizedDescription
        }
    }
}

struct LoadsListView: View {
    
    @ObservedObject var viewModel = LoadsListViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.loads, id: \.self) { loadItem in
                        
                        HStack(alignment: .top) {
                            VStack(alignment: .leading) {
                                Text("Load: \(loadItem.loadId)")
                                Text("Carrier: \(loadItem.carrierCode)")
//                                Text("Lat: \(loadItem.coordinates?.lat ?? 0.0)")
                            }
                            
                            VStack(alignment: .leading) {
                                Text("Vehicle ID: \(loadItem.vehicleId ?? "N/A")")
//                                Text("\(loadItem.coordinates.lat)\(loadItem.coordinates.long)")
//                                Text(loadItem.lastTelemetryTime)
                                Text("Type: \(loadItem.vehicleType)")
//                                Text("Long: \(loadItem.coordinates?.long ?? 0.0)")
                            }
                        }
                        .padding(.vertical, 5)
                        
                    }
                }
                .padding()
                .onAppear(perform: getLoadsList)
            }
            .navigationTitle("Loads List")
        }
    }
    
    func getLoadsList() {
        Task {
            await viewModel.getLoadsList()
        }
    }
}

struct LoadsListView_Previews: PreviewProvider {
    static var previews: some View {
        LoadsListView()
    }
}
