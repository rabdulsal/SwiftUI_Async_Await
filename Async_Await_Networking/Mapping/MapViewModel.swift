//
//  MapViewModel.swift
//  Async_Await_Networking
//
//  Created by Rashad Abdul-Salam on 7/23/23.
//

import Foundation
import MapKit
import CoreLocation

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var mapView = MKMapView()
    // Region...
    @Published var region: MKCoordinateRegion?
    // Alert.....
    @Published var permissionDenied = false
    // Map Type
    @Published var mapType: MKMapType = .standard
    // Search Text
    @Published var searchText = ""
    // Searched Places
    @Published var places = [Place]()
    // Selected Place
    @Published var selectedPlace: Place?
    // Directions Steps
    @Published var directions = [String]()
    
    var userLocationCoordinates: CLLocationCoordinate2D? {
        return mapView.annotations.filter { $0.isKind(of: MKUserLocation.self) }.first?.coordinate
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .denied:
            permissionDenied.toggle()
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            manager.requestLocation()
        default: ()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("LocationManager Error: \(error.localizedDescription)")
    }
    
    // Getting user Region.....
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        self.setRegion()
    }
    
    func setRegion(_ region: MKCoordinateRegion? = nil) {
        guard let region = region else {
            self.region = MKCoordinateRegion(center: userLocationCoordinates!, latitudinalMeters: 1000, longitudinalMeters: 1000)
            setRegion(self.region)
            return
        }
        // Updating Map.....
        self.mapView.setRegion(region, animated: true)
        
        // Smooth Animations....
        self.mapView.setVisibleMapRect(self.mapView.visibleMapRect, animated: true)
    }
    
    func searchQuery() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        
        places.removeAll()
        
        // Fetch....
        MKLocalSearch(request: request).start { (response, _) in
            guard let result = response else { return }
            
            self.places = result.mapItems.compactMap({ item -> Place? in
                return Place(place: item.placemark)
            })
        }
    }
    
    // Pick Search Result
    
    func selectPlace(place: Place) {
        
        // Refresh Content
        refreshContent()
        
        // Show Pin on Map
        selectedPlace = place
        
        guard let coordinate = place.place.location?.coordinate else { return }
        
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = coordinate
        pointAnnotation.title = place.place.name ?? "No Name"
        
        // Remove All Old Annotations
        
        mapView.addAnnotation(pointAnnotation)
        
        // Move Map to that Location....
        
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        
        setRegion(coordinateRegion)
    }
    
    func makeDirections(coordinate: CLLocationCoordinate2D) {
        guard let userCoordinates = userLocationCoordinates
        else { return }
        
        let p1 = MKPlacemark(coordinate: userCoordinates)
        let p2 = MKPlacemark(coordinate: coordinate)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: p1)
        request.destination = MKMapItem(placemark: p2)
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            guard let route = response?.routes.first else { return }

            self.mapView.addOverlay(route.polyline)
            self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), animated: true)
            
            // Set Direction Steps
            self.directions = route.steps.map { $0.instructions }.filter { !$0.isEmpty }
        }
    }
    
    func makeDirections(with annotation: MKAnnotation) {
        let coordinate = annotation.coordinate
        self.makeDirections(coordinate: coordinate)
    }
    
    private func refreshContent() {
        selectedPlace = nil
        searchText = ""
        directions = []
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)
    }
}

extension MapViewModel: AnnotationSelectionDelegate {
    func updateMapView(with region: MKCoordinateRegion) {
        mapView.setRegion(region, animated: true)
    }
    
    
    func selectedAnnotation(_ annotation: MKAnnotation) {
        self.makeDirections(with: annotation)
    }
}
