//
//  RouteDetailsView.swift
//  Async_Await_Networking
//
//  Created by Rashad Abdul-Salaam on 9/12/23.
//

import SwiftUI

struct RouteDetailsView: View {
    let loadItem: RouteItem
    
    var transitStatus: String {
        ""
    }
    
    var body: some View {
            
        VStack {
            // Transit Bar
            HStack(alignment: .top, spacing: 10) {
                VStack(alignment: .leading) {
                    Text("In Transit")
                    Text("Current Stop: \(loadItem.currentStopCount) of \(loadItem.totalStopCount)")
                    
                }
                
                VStack(alignment: .leading) {
                    
                    Text("Driver: \(loadItem.driver)")
                    Text("Delivery @ \(loadItem.destination.title)")
                }
            }
            
            // Stops List
            
            
            Spacer()
        }
        .navigationTitle(loadItem.id)
        .navigationBarTitleDisplayMode(.inline)
        .padding()
    }
}

struct RouteDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RouteDetailsView(
            loadItem: RouteItem(
            id: "DEF",
            stops: [
                    RouteStop(id: "4", title: "", locationCode: "WMT-5280", stopNumber: 1, scheduledArrival: "", arrivalState: "previous"),
                    RouteStop(id: "5", title: "", locationCode: "TNB-600159706", stopNumber: 2, scheduledArrival: "", arrivalState: "previous"),
                    RouteStop(id: "6", title: "", locationCode: "TNB-600159706", stopNumber: 3, scheduledArrival: "", arrivalState: "current"),
                    RouteStop(id: "7", title: "SBUX-ATL47931", locationCode: "WMT-2339", stopNumber: 4, scheduledArrival: "", arrivalState: "future")
            ],
            driver: "Prof. Dumbledore",
            transitStatus: "in_transit")
        )
    }
}
