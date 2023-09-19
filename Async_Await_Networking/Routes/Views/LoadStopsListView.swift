//
//  LoadStopsListView.swift
//  Async_Await_Networking
//
//  Created by Rashad Abdul-Salaam on 9/14/23.
//

import SwiftUI

struct LoadStopsListView: View {
    
    let loadItem: RouteItem
    
    var body: some View {
        
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(loadItem.stops, id: \.self) { stop in
                    
                    
                    // TODO: Wrap in RoundedRect ZStack?
                    HStack {
                        // Stop Count
                        switch stop.arrivalStateType {
                        case .previous:
                            Text("\(stop.stopNumber)")
                                .padding()
                                .background(.gray)
                                .foregroundColor(.primary)
                                .font(.system(size: 12, weight: .bold))
                                .border(.gray, width: 2.0)
                        case .current:
                            Text("\(stop.stopNumber)")
                                .padding()
                                .background(.blue)
                                .foregroundColor(.primary)
                                .font(.system(size: 12, weight: .bold))
                                .border(.gray, width: 2.0)
                            
                        case .future:
                            Text("\(stop.stopNumber)")
                                .padding()
                                .background(.teal)
                                .foregroundColor(.primary)
                                .font(.system(size: 12, weight: .bold))
                                .border(.gray, width: 2.0)
                            
                        }
                        
                        // Stop Details
                        VStack(alignment: .leading) {
                            
                            switch stop.arrivalStateType {
                            
                            case .previous:
                                Text("\(stop.title)")
                                    .foregroundColor(.secondary)
                                    .font(.system(size: 12, weight: .bold))
                                
                                Text("Actual Arrival: \(stop.actualArrival ?? "")")
                                    .foregroundColor(.primary)
                                    .font(.system(size: 12))
                                
                                Text("Actual Departure: \(stop.actualDeparture ?? "")")
                                    .foregroundColor(.primary)
                                    .font(.system(size: 12))
                            case .current:
                                VStack(alignment: .leading) {
                                    Text("\(stop.title)")
                                        .foregroundColor(.primary)
                                        .font(.system(size: 12, weight: .bold))
                                    
                                    Text("Scheduled Arrival: \(stop.scheduledArrival)")
                                        .foregroundColor(.primary)
                                        .font(.system(size: 12))
                                    
                                    Text("NOT ARRIVED")
                                        .foregroundColor(.primary)
                                        .font(.system(size: 12))
                                }
                                .padding(.vertical, 10)
                                
                            case .future:
                                
                                Text("\(stop.title)")
                                    .foregroundColor(.primary)
                                    .font(.system(size: 12, weight: .bold))
                                
                                Text("Scheduled Arrival: \(stop.scheduledArrival)")
                                    .foregroundColor(.primary)
                                    .font(.system(size: 12))
                            }
                            
                            
                        }
                        
                        Spacer()
                        // Delivery Type
                        
                        Text("DL")
                            .foregroundColor(.secondary)
                            .bold()
                    }
                }
//                .padding(EdgeInsets(top: 5, leading: 16, bottom: 5, trailing: 16))
            }
        }
    }
}

struct LoadStopsListView_Previews: PreviewProvider {
    static var previews: some View {
        LoadStopsListView(loadItem: RouteItem.mockLoadItem)
    }
}
