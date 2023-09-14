//
//  LoadItem.swift
//  Async_Await_Networking
//
//  Created by Rashad Abdul-Salaam on 9/14/23.
//

import Foundation

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
