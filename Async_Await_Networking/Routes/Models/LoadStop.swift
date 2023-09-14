//
//  LoadStop.swift
//  Async_Await_Networking
//
//  Created by Rashad Abdul-Salaam on 9/14/23.
//

import Foundation

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
