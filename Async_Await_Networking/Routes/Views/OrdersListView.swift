//
//  OrdersListView.swift
//  Async_Await_Networking
//
//  Created by Rashad Abdul-Salaam on 9/21/23.
//

import SwiftUI



struct OrdersListView: View {
    
    @ObservedObject var viewModel = OrdersListViewModel()
    @State var presentError = false
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    // TODO: User Mock OrdersListData until network back online
                    ForEach(/*OrdersListData.mockOrders*/ viewModel.orders, id: \.self) { orderItem in
                        
                        NavigationLink (destination: {
                            OrderDetailsView(orderItem: orderItem)
                        }, label: {
                            HStack(alignment: .top) {
                                VStack(alignment: .leading) {
                                    
                                    SCISimpleHorizontalTitleTextDisplayView(title: "Trailer:", text: " \(orderItem.trailerNum)")
                                    
                                    SCISimpleHorizontalTitleTextDisplayView(title: "Carrier:", text: " \(orderItem.carrierCode)")
                                    SCISimpleHorizontalTitleTextDisplayView(title: "Load ID:", text: " \(orderItem.loadId)")
                                }
                                
                                VStack(alignment: .leading) {
                                    
                                    SCISimpleHorizontalTitleTextDisplayView(title: "Customer:", text: orderItem.customerCode)
                                    
                                    SCISimpleHorizontalTitleTextDisplayView(title: "Origin:", text: orderItem.originStopLocality)
                                    
                                    SCISimpleHorizontalTitleTextDisplayView(title: "Destination:", text: orderItem.destinationStopLocality)
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2) // Slight drop shadow
                            .padding(.horizontal)
                        })
                        .padding(.vertical, 5)
                    }
                }
                .onAppear(perform: getOrdersList)
                .alert(isPresented: .constant(!viewModel.ordersFetchError.isEmpty), content: {
                    Alert(title: Text(viewModel.ordersFetchError))
                    
                })
            }
            .navigationTitle("Orders List")
            .background(Color(white: 0.95))
        }
    }
    
    func getOrdersList() {
            
        Task {
            await viewModel.getOrdersList()
            
        }
    }
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
