//
//  OrdersListView.swift
//  Async_Await_Networking
//
//  Created by Rashad Abdul-Salaam on 9/21/23.
//

import SwiftUI



struct OrdersListView: View {
    
    @ObservedObject var viewModel = OrdersListViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.orders, id: \.self) { orderItem in
                        
                        NavigationLink (destination: {
                            OrderDetailsView(orderItem: orderItem)
                        }, label: {
                            HStack(alignment: .top) {
                                VStack(alignment: .leading) {
                                    
                                    // TODO: Wrap Text in HStack to separate .secondary title from .primary description
                                    SCISimpleHorizontalTitleTextDisplayView(title: "Trailer:", text: " \(orderItem.trailerNum)")
                                    
                                    SCISimpleHorizontalTitleTextDisplayView(title: "Carrier:", text: " \(orderItem.carrierCode)")
                                    SCISimpleHorizontalTitleTextDisplayView(title: "Load ID:", text: " \(orderItem.loadId)")
                                    
                                    //                                Text("Lat: \(orderItem.coordinates?.lat ?? 0.0)")
                                }
                                
                                VStack(alignment: .leading) {
                                    
                                    SCISimpleHorizontalTitleTextDisplayView(title: "Customer:", text: orderItem.customerCode)
                                    
                                    SCISimpleHorizontalTitleTextDisplayView(title: "Origin:", text: orderItem.originStopLocality)
                                    
                                    SCISimpleHorizontalTitleTextDisplayView(title: "Destination:", text: orderItem.destinationStopLocality)
                                    //                                Text("Origin: \(orderItem.originStopLocality)")
                                    //                                Text("Lat: \(orderItem.destination?.coordinates.lat ?? 0.0)")
                                    //                                Text("\(orderItem.coordinates.lat)\(orderItem.coordinates.long)")
                                    //                                Text(orderItem.lastTelemetryTime)
                                    //                                Text("Destination: \(orderItem.destinationStopLocality)")
                                    //                                Text("Long: \(orderItem.destination?.coordinates.long ?? 0.0)")
                                }
                            }
                            .padding(.vertical, 5)
                        })
                    }
                }
                .padding()
                .task {
                    await viewModel.getOrdersList()
                }
            }
            .navigationTitle("Orders List")
        }
    }
    
//    func getLoadsList() {
//        Task {
//            await viewModel.getOrdersList()
//        
//        }
//    }
}

struct SCISimpleHorizontalTitleTextDisplayView : View {
    
    let title: String
    let text: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text(title)
                .font(.system(size: 14))
                .foregroundColor(.secondary)
                .bold()
            Text(text)
                .font(.system(size: 15))
                .foregroundColor(.primary)
        }
    }
}


struct OrdersListView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersListView()
    }
}
