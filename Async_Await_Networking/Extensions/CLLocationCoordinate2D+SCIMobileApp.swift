//
//  CLLocationCoordinate2D+SCIMobileApp.swift
//  Async_Await_Networking
//
//  Created by Abdul-Salaam, Rashad (Penske, Insight Global) on 9/28/23.
//

import Foundation
import MapKit

extension CLLocationCoordinate2D {
    
    init(coordinates: SCIGeoCoordinates) {
        self.init(latitude: coordinates.lat, longitude: coordinates.long)
    }
}
