//
//  RoutesListView.swift
//  Async_Await_Networking
//
//  Created by Rashad Abdul-Salaam on 9/12/23.
//

import SwiftUI

struct RoutesListView: View {
    
    @ObservedObject var viewModel = RoutesListViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(RoutesListViewModel.mockRoutes, id: \.self) { route in
                        
                        NavigationLink (destination: {
                            RouteDetailsView(loadItem: route)
                        }, label: {
                            // TODO: Wrap in RoundedRect ZStack?
                            
                                VStack(alignment: .leading) {
                                    Text(route.id)
                                        .foregroundColor(.primary)
                                        .font(.system(size: 12, weight: .bold))
                                    
                                    Text(route.transitStatusMessage)
                                        .foregroundColor(.secondary)
                                        .font(.system(size: 12))
                                    //                        .font(.caption)
                                    
                                    //                        }
                                    // Show Route ProgressBar
                                    CustomProgressBar(value: route.currentStopCount, maxProgress: route.totalStopCount, transitStatusType: route.transitStatusType).frame(height: CustomProgressBar.DefaultHeight)
                                }
                                .padding()
                                .border(.gray, width: 2.0)
                                .cornerRadius(4.0)
                                .background(.white)
                        })
                    }
                    .padding(EdgeInsets(top: 5, leading: 16, bottom: 5, trailing: 16))
                }
                
                
            }
            .navigationTitle("Routes In Transit")
            .background(Color(uiColor: UIColor(red: 250.0, green: 250.0, blue: 250.0, alpha: 1)))
        }
    }
}

struct RoutesListView_Previews: PreviewProvider {
    static var previews: some View {
        RoutesListView()
    }
}
