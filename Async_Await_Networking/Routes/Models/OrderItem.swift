//
//  OrderItem.swift
//  Async_Await_Networking
//
//  Created by Rashad Abdul-Salaam on 9/20/23.
//

import Foundation

// MARK: - StopAddress
struct StopAddress: Codable, Hashable {
    
    /**
     
     {
     addressLines: [
     "13601 INDEPENDANCE PARKWAY"
     ],
     locality: "FORT WORTH",
     region: "TX",
     country: null,
     postCode: null
     },
     
     */
    
    let addressLines: [String]
    let locality: String
    let region: String
    let country: String?
    let postCode: String?
    
    var prettifiedAddressLines: String {
//        var addyBuffer = ""
//        for i in 0..<addressLines.count {
//            let line = addressLines[i]
//            if i != 0 {
//                addyBuffer += " \(line)"
//            } else {
//                addyBuffer += "\(line)"
//            }
//        }
//        return addyBuffer
        return addressLines.first ?? ""
    }
    
}

import MapKit

// MARK: - LoadStop / GeoCoordinates
struct SCIGeoCoordinates: Codable, Hashable {
    
    static let mockOrigCoords = SCIGeoCoordinates(lat: 37.7749, long: -122.4194)
    static let mockDestCoords = SCIGeoCoordinates(lat: 34.0522, long: -118.2437)
    
    let lat: Double
    let long: Double
    var cllocationCoord2D: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(coordinates: self)
    }
}

struct LoadStop: Codable, Hashable {
    
    static let mockLoadOrigin = LoadStop(stopId: "600062899", stopNumber: nil, name: "SCHRADER ELECTRONICS LTD", address: StopAddress(addressLines: ["13601 INDEPENDANCE PARKWAY"], locality: "FORT WORTH", region: "TX", country: nil, postCode: nil), coordinates: SCIGeoCoordinates(lat: 32.978, long: -97.2544), isWarehouse: false, timeZone: "America/Chicago")
    
    static let mockLoadDestination = LoadStop(stopId: "601172593", stopNumber: 2, name: "AP20A", address: StopAddress(addressLines: ["1 CANADIAN ROAD"], locality: "OAKVILLE", region: "ON", country: nil, postCode: nil), coordinates: SCIGeoCoordinates(lat: 43.4756, long: -79.6696), isWarehouse: false, timeZone: "America/Toronto")
    
//    let origin: {
    let stopId: String
    let stopNumber: Int?
    let name: String
    let address: StopAddress
    /**
     -- StopAddress data --
    let addressLines: [String]
    let locality: String
    let region: String
    var country: String?
    var postCode: String?
     */
    var coordinates: SCIGeoCoordinates
    let isWarehouse: Bool
    var timeZone: String
    
}

// MARK: - OrderItem
struct OrderItem: Codable, Hashable {
    
    static let mockOrder: OrderItem = OrderItem(orderNumber: "33362209-33362209-BVCUH-33362209-33362209-BVCUH-686765702-686765702", orderNum: "33362209-33362209-BVCUH-33362209-33362209-BVCUH-686765702-686765702", customerCode: "FORD", loadId: "602422112", load: nil, numberOfStops: 2, trailerNumber: "UMXU882949", trailerNum: "UMXU882949", carrierCode: "APAD", originStopLocality: "FORT WORTH", origin: LoadStop.mockLoadOrigin, destinationStopLocality: "OAKVILLE", destination: LoadStop.mockLoadDestination, actualTrailerArrivalDatetime: "2023-09-09T14:21:18Z", actualOrderReceivedDatetime: "2023-09-09T15:10:53Z", actualOrderDispatchedDatetime: "2023-09-13T00:00:14Z", expectedShipDatetime: "2023-09-11T20:30:00Z", expectedDeliveryDatetime: "2023-09-21T22:30:00Z", actualDeliveryDatetime: nil, expectedDelivery: "2023-09-21T22:30:00Z", orderStatus: "closed", onTimeStatus: "on-time", orderDirection: "cross-warehouse", site: "PC75A", timeline: nil, hasTransportationInfo: true, hasWarehouseInfo: true, hasPlanInformation: true, hasTransportationBeenSkipped: false, sourceSystem: "TM,WMS-OB,WMS-IB")
    
    static let mockOrder2: OrderItem = OrderItem(orderNumber: "43362209-33362209-BVCUH-33362209-33362209-BVCUH-686765702-686765702", orderNum: "43362209-33362209-BVCUH-33362209-33362209-BVCUH-686765702-686765702", customerCode: "FORD", loadId: "602422112", load: nil, numberOfStops: 2, trailerNumber: "UMXU882949", trailerNum: "UMXU882949", carrierCode: "APAD", originStopLocality: "FORT WORTH", origin: LoadStop(stopId: "600062899", stopNumber: nil, name: "SCHRADER ELECTRONICS LTD", address: StopAddress(addressLines: ["13601 INDEPENDANCE PARKWAY"], locality: "FORT WORTH", region: "TX", country: nil, postCode: nil), coordinates: SCIGeoCoordinates(lat: 32.978, long: -97.2544), isWarehouse: false, timeZone: "America/Chicago"), destinationStopLocality: "OAKVILLE", destination: LoadStop(stopId: "601172593", stopNumber: 2, name: "AP20A", address: StopAddress(addressLines: ["1 CANADIAN ROAD"], locality: "OAKVILLE", region: "ON", country: nil, postCode: nil), coordinates: SCIGeoCoordinates(lat: 43.4756, long: -79.6696), isWarehouse: false, timeZone: "America/Toronto"), actualTrailerArrivalDatetime: "2023-09-09T14:21:18Z", actualOrderReceivedDatetime: "2023-09-09T15:10:53Z", actualOrderDispatchedDatetime: "2023-09-13T00:00:14Z", expectedShipDatetime: "2023-09-11T20:30:00Z", expectedDeliveryDatetime: "2023-09-21T22:30:00Z", actualDeliveryDatetime: nil, expectedDelivery: "2023-09-21T22:30:00Z", orderStatus: "closed", onTimeStatus: "on-time", orderDirection: "cross-warehouse", site: "PC75A", timeline: nil, hasTransportationInfo: true, hasWarehouseInfo: true, hasPlanInformation: true, hasTransportationBeenSkipped: false, sourceSystem: "TM,WMS-OB,WMS-IB")
    
    static let mockOrder3: OrderItem = OrderItem(orderNumber: "53362209-33362209-BVCUH-33362209-33362209-BVCUH-686765702-686765702", orderNum: "33362209-33362209-BVCUH-33362209-33362209-BVCUH-686765702-686765702", customerCode: "FORD", loadId: "602422112", load: nil, numberOfStops: 2, trailerNumber: "UMXU882949", trailerNum: "UMXU882949", carrierCode: "APAD", originStopLocality: "SAN FRANCISO", origin: LoadStop(stopId: "600062899", stopNumber: nil, name: "SCHRADER ELECTRONICS LTD", address: StopAddress(addressLines: ["13601 INDEPENDANCE PARKWAY"], locality: "SAN FRANCISCO", region: "TX", country: nil, postCode: nil), coordinates: SCIGeoCoordinates.mockOrigCoords, isWarehouse: false, timeZone: "America/Chicago"), destinationStopLocality: "LOS ANGELES", destination: LoadStop(stopId: "601172593", stopNumber: 2, name: "AP20A", address: StopAddress(addressLines: ["1 CANADIAN ROAD"], locality: "LOS ANGELES", region: "ON", country: nil, postCode: nil), coordinates: SCIGeoCoordinates.mockDestCoords, isWarehouse: false, timeZone: "America/Toronto"), actualTrailerArrivalDatetime: "2023-09-09T14:21:18Z", actualOrderReceivedDatetime: "2023-09-09T15:10:53Z", actualOrderDispatchedDatetime: "2023-09-13T00:00:14Z", expectedShipDatetime: "2023-09-11T20:30:00Z", expectedDeliveryDatetime: "2023-09-21T22:30:00Z", actualDeliveryDatetime: nil, expectedDelivery: "2023-09-21T22:30:00Z", orderStatus: "closed", onTimeStatus: "on-time", orderDirection: "cross-warehouse", site: "PC75A", timeline: nil, hasTransportationInfo: true, hasWarehouseInfo: true, hasPlanInformation: true, hasTransportationBeenSkipped: false, sourceSystem: "TM,WMS-OB,WMS-IB")
    
    enum OrderStatus: String {
        case closed
        case delivered
        case inTransit = "in-transit"
        case tenderAccepted = "tender-accepted"
    }
    
    enum OnTimeStatus: String {
        case onTime = "on-time"
        case late
    }
    
    enum OrderDirection: String {
        case crossWarehouse = "cross-warehouse"
        case outbound
    }
    
    enum Site: String {
        case PC75A
        case PC07A
        case PC02A
        case PC04A
    }
    
    var humanReadableExpectedDatetime: String {
        return DateFormatter.makeHumanReadableDateString(inputDateString: self.expectedDeliveryDatetime)
    }
    
    /**
     
     orderNumber: "33362209-33362209-BVCUH-33362209-33362209-BVCUH-686765702-686765702",
     orderNum: "33362209-33362209-BVCUH-33362209-33362209-BVCUH-686765702-686765702",
     customerCode: "FORD",
     loadId: "602422112",
     load: null,
     numberOfStops: 2,
     trailerNumber: "UMXU882949",
     trailerNum: "UMXU882949",
     carrierCode: "APAD",
     originStopLocality: "FORT WORTH",
     origin: {
     stopId: "600062899",
     stopNumber: null,
     name: "SCHRADER ELECTRONICS LTD",
     address: {
     addressLines: [
     "13601 INDEPENDANCE PARKWAY"
     ],
     locality: "FORT WORTH",
     region: "TX",
     country: null,
     postCode: null
     },
     coordinates: {
     lat: 32.978,
     long: -97.2544
     },
     isWarehouse: false,
     timeZone: "America/Chicago"
     },
     destinationStopLocality: "OAKVILLE",
     destination: {
     stopId: "601172593",
     stopNumber: 2,
     name: "AP20A",
     address: {
     addressLines: [
     "1 CANADIAN ROAD"
     ],
     locality: "OAKVILLE",
     region: "ON",
     country: null,
     postCode: null
     },
     coordinates: {
     lat: 43.4756,
     long: -79.6696
     },
     isWarehouse: false,
     timeZone: "America/Toronto"
     },
     actualTrailerArrivalDatetime: "2023-09-09T14:21:18Z",
     actualOrderReceivedDatetime: "2023-09-09T15:10:53Z",
     actualOrderDispatchedDatetime: "2023-09-13T00:00:14Z",
     expectedShipDatetime: "2023-09-11T20:30:00Z",
     actualShipDatetime: null,
     orderShippedDatetime: null,
     expectedDeliveryDatetime: "2023-09-21T22:30:00Z",
     actualDeliveryDatetime: null,
     expectedDelivery: "2023-09-21T22:30:00Z",
     actualDelivery: null,
     orderStatus: "closed",
     onTimeStatus: "on-time",
     orderDirection: "cross-warehouse",
     penskeService: null,
     site: "PC75A",
     timeline: null,
     hasTransportationInfo: true,
     hasWarehouseInfo: true,
     hasPlanInformation: true,
     hasTransportationBeenSkipped: false,
     sourceSystem: "TM,WMS-OB,WMS-IB"
     
     */
    
    let orderNumber: String
    let orderNum: String
    let customerCode: String
    let loadId: String
    let load: LoadItem? // TODO: Check this once Load data provided
    let numberOfStops: Int
    let trailerNumber: String
    let trailerNum: String
    let carrierCode: String
    let originStopLocality: String
    let origin: LoadStop?
    
    let destinationStopLocality: String
    let destination: LoadStop?
    
    let actualTrailerArrivalDatetime: String
    let actualOrderReceivedDatetime: String
    let actualOrderDispatchedDatetime: String
    let expectedShipDatetime: String
    var actualShipDatetime: String?
    var orderShippedDatetime: String?
    let expectedDeliveryDatetime: String
    let actualDeliveryDatetime: String?
    let expectedDelivery: String
    var actualDelivery: String?
    let orderStatus: String
    let onTimeStatus: String
    let orderDirection: String
    var penskeService: String?
    let site: String
    let timeline: String?
    var hasTransportationInfo: Bool
    var hasWarehouseInfo: Bool
    var hasPlanInformation: Bool
    var hasTransportationBeenSkipped: Bool
    let sourceSystem: String
    
}

// MARK: - OrdersListData
struct OrdersListData: Codable {
    
    static let mockOrders: [OrderItem] = [
        OrderItem.mockOrder,
        OrderItem.mockOrder2,
        OrderItem.mockOrder3
    ]
    
    let data: [OrderItem]
}
