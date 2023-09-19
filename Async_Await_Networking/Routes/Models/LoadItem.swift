//
//  LoadItem.swift
//  Async_Await_Networking
//
//  Created by Rashad Abdul-Salaam on 9/14/23.
//

import Foundation

struct RouteItem: Codable, Hashable {
    
    static let mockLoadItem: RouteItem = RouteItem(
        id: "DEF",
        stops: [
                RouteStop(id: "4", title: "BELLEVUE - HWY 100", locationCode: "WMT-5280", stopNumber: 1, scheduledArrival: "", arrivalState: "previous"),
                RouteStop(id: "5", title: "CHARLOTTE PIKE AND I40", locationCode: "TNB-600159706", stopNumber: 2, scheduledArrival: "", arrivalState: "previous"),
                RouteStop(id: "6", title: "MURFREESBOROR - THE AVENUE", locationCode: "TNB-600159706", stopNumber: 3, scheduledArrival: "", arrivalState: "current"),
                RouteStop(id: "7", title: "STARBUCKS LAWRENCEVILLE", locationCode: "SBUX-ATL47931", stopNumber: 4, scheduledArrival: "", arrivalState: "future")
        ],
        driver: "Prof. Dumbledore",
        transitStatus: "in_transit")
    
    
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
