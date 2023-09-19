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
            transitInfoHeader
            
            Divider()
            
            // Stops List
            LoadStopsListView(loadItem: loadItem)
            
            Spacer()
        }
        .navigationTitle(loadItem.id)
        .navigationBarTitleDisplayMode(.inline)
        .padding()
    }
    
    @ViewBuilder
    var transitInfoHeader: some View {
        HStack(alignment: .top, spacing: 10) {
            VStack(alignment: .leading) {
                Text("In Transit")
                    .bold()
                
                Text("Current Stop: \(loadItem.currentStopCount) of \(loadItem.totalStopCount)")
                    .font(.system(size: 12))
                
            }
            
            Spacer()
            
            VStack(alignment: .leading) {
                
                Text("Driver: \(loadItem.driver)")
                    .font(.system(size: 12))
                
                Text("Delivery @ \(loadItem.destination.locationCode)")
                    .font(.system(size: 12))
            }
        }
    }
}

struct RouteDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RouteDetailsView(
            loadItem: RouteItem.mockLoadItem
        )
    }
}
