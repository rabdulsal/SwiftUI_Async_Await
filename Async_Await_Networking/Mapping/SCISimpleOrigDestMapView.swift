//
//  SCISimpleOrigDestMapView.swift
//  Async_Await_Networking
//
//  Created by Abdul-Salaam, Rashad (Penske, Insight Global) on 9/27/23.
//

import SwiftUI
import MapKit

struct SCISimpleOrigDestMapView: UIViewRepresentable {
    
    // TODO: Eventually inject a LoadStop object
    
    let originCoordinate: RSGeoCoordinates // San Francisco
    let destinationCoordinate: RSGeoCoordinates // Los Angeles

    func makeUIView(context: Context) -> MKMapView {
        MKMapView()
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Remove any existing annotations
        uiView.removeAnnotations(uiView.annotations)

        // Create annotations for the origin and destination
        let originAnnotation = MKPointAnnotation()
        originAnnotation.coordinate = originCoordinate.cllocationCoord2D
        originAnnotation.title = "Origin"
        
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.coordinate = destinationCoordinate.cllocationCoord2D
        destinationAnnotation.title = "Destination"
        
        // Add the annotations to the map
        uiView.addAnnotations([originAnnotation, destinationAnnotation])
        
        // Calculate the distance between the two points in meters
        let originPoint = MKMapPoint(originCoordinate.cllocationCoord2D)
        let destinationPoint = MKMapPoint(destinationCoordinate.cllocationCoord2D)
        let distance = originPoint.distance(to: destinationPoint)
        
        // Set the map region to show both annotations
        let centerCoordinate = CLLocationCoordinate2D(
            latitude: (originCoordinate.lat + destinationCoordinate.lat) / 2,
            longitude: (originCoordinate.long + destinationCoordinate.long) / 2
        )
        
//        let span = MKCoordinateSpan(latitudeDelta: 35, longitudeDelta: 35)
        
        // Calculate the span based on the distance
        let span = MKCoordinateSpan(
            latitudeDelta: distance / 111000, // Approximately 111,000 meters per degree of latitude
            longitudeDelta: distance / (111000 * cos(centerCoordinate.latitude * .pi / 180)) // Adjust for longitude
        )
        
        let region = MKCoordinateRegion(center: centerCoordinate, span: span)
        uiView.setRegion(region, animated: true)
    }
}

struct SCISimpleMapContentView: View {

    var body: some View {
        SCISimpleOrigDestMapView(originCoordinate: RSGeoCoordinates.mockOrigCoords, destinationCoordinate: RSGeoCoordinates.mockDestCoords)
            .frame(height: 300)
    }
}

extension CLLocationCoordinate2D {
    
    init(coordinates: RSGeoCoordinates) {
        self.init(latitude: coordinates.lat, longitude: coordinates.long)
    }
}

#Preview {
    SCISimpleMapContentView()
}
