//
//  LoadsListViewModel.swift
//  Async_Await_Networking
//
//  Created by Rashad Abdul-Salaam on 9/14/23.
//

import Foundation

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
