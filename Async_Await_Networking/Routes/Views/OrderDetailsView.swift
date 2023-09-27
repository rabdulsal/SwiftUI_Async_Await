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
                        Text(address?.region ?? "")
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
                        Text(address?.region ?? "")
                    }
                }
            }
            
//            Spacer()
        }
        Spacer()
    }
}

#Preview {
    OrderDetailsView(orderItem: OrderItem.mockOrder)
}
