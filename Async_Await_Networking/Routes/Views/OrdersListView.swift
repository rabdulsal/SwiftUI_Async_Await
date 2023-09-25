//
//  OrdersListView.swift
//  Async_Await_Networking
//
//  Created by Rashad Abdul-Salaam on 9/21/23.
//

import SwiftUI

class OrdersListViewModel: ObservableObject {
    @Published var orders = [OrderItem]()
    @Published var ordersFetchError = ""
    
    private var networkingService = OrdersNetworkingService()
    
    func getOrdersList(pageSize: Int = 10) async {
        do {
            let result = try await self.networkingService.getOrders()
            
            switch result {
            case .success(let ordersList):
                DispatchQueue.main.async {
                    self.orders = ordersList.data
                }
            case .failure(let error): throw error
            }
        } catch {
            self.ordersFetchError = error.localizedDescription
        }
    }
}

struct OrdersListView: View {
    
    @ObservedObject var viewModel = OrdersListViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.orders, id: \.self) { orderItem in
                        
                        
                        HStack(alignment: .top) {
                            VStack(alignment: .leading) {
                                Text("Trailer: \(orderItem.trailerNum)")
                                Text("Carrier: \(orderItem.carrierCode)")
                                Text("Num Stops: \(orderItem.numberOfStops)")
                                Text("Address: \(orderItem.origin?.address.prettifiedAddressLines ?? "")")
//                                Text("Lat: \(orderItem.coordinates?.lat ?? 0.0)")
                            }
                            
                            VStack(alignment: .leading) {
                                Text("Origin: \(orderItem.originStopLocality)")
                                Text("Lat: \(orderItem.destination?.coordinates.lat ?? 0.0)")
//                                Text("\(orderItem.coordinates.lat)\(orderItem.coordinates.long)")
//                                Text(orderItem.lastTelemetryTime)
                                Text("Destination: \(orderItem.destinationStopLocality)")
                                Text("Long: \(orderItem.destination?.coordinates.long ?? 0.0)")
                            }
                        }
                        .padding(.vertical, 5)
                        
                    }
                }
                .padding()
                .onAppear(perform: getLoadsList)
            }
            .navigationTitle("Orders List")
        }
    }
    
    func getLoadsList() {
        Task {
            await viewModel.getOrdersList()
        
        }
    }
}


struct OrdersListView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersListView()
    }
}
