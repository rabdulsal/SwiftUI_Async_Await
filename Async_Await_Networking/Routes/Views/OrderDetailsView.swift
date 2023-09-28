//
//  OrderDetailsView.swift
//  Async_Await_Networking
//
//  Created by Abdul-Salaam, Rashad (Penske, Insight Global) on 9/27/23.
//

import SwiftUI

struct OrderDetailsView: View {
    
    let orderItem: OrderItem
    
    var body: some View {
        
        VStack(spacing: 0) {
            VStack {
                SCISimpleOrigDestMapView(originCoordinate: orderItem.origin?.coordinates ?? RSGeoCoordinates.mockOrigCoords, destinationCoordinate: orderItem.destination?.coordinates ?? RSGeoCoordinates.mockDestCoords)
                    .frame(height: UIScreen.main.bounds.height / 2)
                    .ignoresSafeArea(.container, edges: .top)
                
                
                HStack(alignment: .top) {
                    // Origin
                    VStack(alignment: .leading) {
                        
                        let address = orderItem.origin?.address
                        
                        Text("Origin Address:")
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                            .bold()
                        Text(address?.prettifiedAddressLines ?? "")
                            .font(.system(size: 15))
                            .foregroundColor(.primary)
                        
                        HStack {
                            Text(address?.locality ?? "")
                                .font(.system(size: 15))
                                .foregroundColor(.primary)
                            Text(address?.region ?? "")
                                .font(.system(size: 15))
                                .foregroundColor(.primary)
                        }
                    }
                    
                    
                    // Destination
                    VStack(alignment: .leading) {
                        
                        let address = orderItem.destination?.address
                        
                        Text("Destination Address:")
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                            .bold()
                        Text(orderItem.destination?.address.prettifiedAddressLines ?? "")
                            .font(.system(size: 15))
                            .foregroundColor(.primary)
                        
                        HStack {
                            Text(address?.locality ?? "")
                                .font(.system(size: 15))
                                .foregroundColor(.primary)
                            Text(address?.region ?? "")
                                .font(.system(size: 15))
                                .foregroundColor(.primary)
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2) // Slight drop shadow
                .padding(.horizontal, 5)
            }
            
            Spacer()
        }
        .background(Color(white: 0.95))
//        Spacer()
    }
}

#Preview {
    OrderDetailsView(orderItem: OrderItem.mockOrder)
}
