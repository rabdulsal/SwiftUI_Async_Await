//
//  RoutesListView.swift
//  Async_Await_Networking
//
//  Created by Rashad Abdul-Salaam on 9/12/23.
//

import SwiftUI


class RoutesListViewModel: ObservableObject {
    
    static let mockRoutes: [RouteItem] = [
            RouteItem(
                id: "ABC",
                stops: [
                    RouteStop(id: "1", title: "", locationCode: "WNF-L-705", stopNumber: 1, scheduledArrival: "", arrivalState: "previous"),
                    RouteStop(id: "2", title: "", locationCode: "WMT-5804", stopNumber: 2, scheduledArrival: "", arrivalState: "previous"),
                    RouteStop(id: "3", title: "", locationCode: "WMT-1432", stopNumber: 3, scheduledArrival: "", arrivalState: "current")
            ], driver: "Harry Potter", transitStatus: "in_transit"),
            RouteItem(
                id: "DEF",
                stops: [
                    RouteStop(id: "4", title: "", locationCode: "WMT-5280", stopNumber: 1, scheduledArrival: "", arrivalState: "previous"),
                    RouteStop(id: "5", title: "", locationCode: "TNB-600159706", stopNumber: 2, scheduledArrival: "", arrivalState: "previous"),
                    RouteStop(id: "6", title: "", locationCode: "TNB-600159706", stopNumber: 3, scheduledArrival: "", arrivalState: "current"),
                    RouteStop(id: "7", title: "", locationCode: "WMT-2339", stopNumber: 4, scheduledArrival: "", arrivalState: "future")
            ], driver: "Harry Potter", transitStatus: "in_transit"),
            RouteItem(
                id: "GHI",
                stops: [
                    RouteStop(id: "8", title: "", locationCode: "WMT-1234", stopNumber: 1, scheduledArrival: "", arrivalState: "future"),
                    RouteStop(id: "9", title: "", locationCode: "WMT-R-1976", stopNumber: 2, scheduledArrival: "", arrivalState: "future")
            ], driver: "Harry Potter", transitStatus: "not_started"),
            RouteItem(
                id: "JKL",
                stops: [
                    RouteStop(id: "10", title: "", locationCode: "WMT-E-0227", stopNumber: 1, scheduledArrival: "", arrivalState: "previous"),
                    RouteStop(id: "11", title: "", locationCode: "WMT-A-1110", stopNumber: 2, scheduledArrival: "", arrivalState: "previous"),
                    RouteStop(id: "12", title: "SBUX-ATLA7931", locationCode: "WMT-J-6879", stopNumber: 3, scheduledArrival: "", arrivalState: "previous")
            ], driver: "Harry Potter", transitStatus: "completed"),
            RouteItem(
                id: "MN0",
                stops: [
                    RouteStop(id: "13", title: "", locationCode: "WMT-R-81780", stopNumber: 1, scheduledArrival: "", arrivalState: "previous"),
                    RouteStop(id: "14", title: "", locationCode: "TNB-600179921", stopNumber: 2, scheduledArrival: "", arrivalState: "current"),
                    RouteStop(id: "15", title: "", locationCode: "TNB-511902937", stopNumber: 3, scheduledArrival: "", arrivalState: "future"),
                    RouteStop(id: "16", title: "", locationCode: "WMT-0987", stopNumber: 4, scheduledArrival: "", arrivalState: "future"),
                    RouteStop(id: "17", title: "", locationCode: "WMT-7654", stopNumber: 5, scheduledArrival: "", arrivalState: "future")
            ], driver: "Harry Potter", transitStatus: "in_transit")
        ]
    
    @Published var routes = [RouteItem]()
    
}

struct RouteStop: Codable, Hashable {
    
    enum ArrivalStateType: String {
        case previous, current, future
    }
    
    let id: String
    let title: String
    let locationCode: String
    let stopNumber: Int
    var actualArrival: String? = nil
    var actualDeparture: String? = nil
    let scheduledArrival: String
    
    var arrivalState: String
    
    var arrivalStateType: ArrivalStateType {
        ArrivalStateType(rawValue: arrivalState) ?? .previous
    }
    
    var transitStatusMessage: String {
        ""
    }
    
//    var driver: "Harry Potter", transitStatus: TransitStatus = .notStarted
//    var scheduledArrival: "", arrivalState: DestinationState = .current
    
//    required init(from decoder:Decoder) throws {
//
//        }
}

struct RouteItem: Codable, Hashable {
    
    enum TransitStatusType: String {
        case notStarted = "not_started"
        case inTransit = "in_transit"
        case completed
    }
    
//    @Published var currentTransitProgress: Int = 0
    
    
    let id: String
    let stops: [RouteStop]
    let driver: String
    
    var transitStatus: String
    
    var transitStatusType: TransitStatusType {
        TransitStatusType(rawValue: transitStatus) ?? .notStarted
    }
    
    var origin: RouteStop {
        stops.first!
    }
    
    var destination: RouteStop {
        stops.last!
    }
    
    var currentStopCount: Int {
        currentStop?.stopNumber ?? 0
    }
    
    var totalStopCount: Int {
        stops.count
    }
    
    var currentStop: RouteStop? {
        stops.filter { $0.arrivalStateType == .current }.first
    }
    
    var transitStatusMessage: String {
        switch transitStatusType {
        case .notStarted:
            return "Route Not Started"
        case .inTransit:
            return "In transit to stop \(currentStopCount) of \(totalStopCount) \(currentStop?.title ?? "") <DL type> @ \(currentStop?.locationCode ?? "")"
            
        case .completed:
            return "Completed \(totalStopCount) Stops: <DL type> @  \(destination.locationCode) \(destination.title)"
        }
    }
}

struct RoutesListView: View {
    
    @ObservedObject var viewModel = RoutesListViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(RoutesListViewModel.mockRoutes, id: \.self) { route in
                    
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
                }
                .padding(EdgeInsets(top: 5, leading: 16, bottom: 5, trailing: 16))
            }
            
            
        }
        .background(Color(uiColor: UIColor(red: 250.0, green: 250.0, blue: 250.0, alpha: 1)))
    }
}

struct RoutesListView_Previews: PreviewProvider {
    static var previews: some View {
        RoutesListView()
    }
}
