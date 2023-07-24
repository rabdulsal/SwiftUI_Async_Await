//
//  MapView.swift
//  Async_Await_Networking
//
//  Created by Rashad Abdul-Salam on 7/22/23.
//

import SwiftUI
import MapKit
import CoreLocation

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var mapView = MKMapView()
    // Region...
    @Published var region: MKCoordinateRegion!
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
    // Selected Annotation
    @Published var selectedAnnotation: MKAnnotation?
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
        
        // Updating Map.....
        self.mapView.setRegion(self.region, animated: true)
        
        // Smooth Animations....
        self.mapView.setVisibleMapRect(self.mapView.visibleMapRect, animated: true)
    }
    
    func searchQuery() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        
        selectedPlace = nil
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
        
        // Show Pin on Map
        
        searchText = ""
        selectedPlace = place
        
        guard let coordinate = place.place.location?.coordinate else { return }
        
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = coordinate
        pointAnnotation.title = place.place.name ?? "No Name"
        
        // Remove All Old Annotations
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(pointAnnotation)
        
        // Move Map to that Location....
        
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
    }
    
    func makeDirections() {
        guard
            let selectionCoordinates = selectedPlace?.place.location?.coordinate,
            let userCoordinates = userLocationCoordinates
        else { return }
        
        let p1 = MKPlacemark(coordinate: userCoordinates)
        let p2 = MKPlacemark(coordinate: selectionCoordinates)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: p1)
        request.destination = MKMapItem(placemark: p2)
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            guard let route = response?.routes.first else { return }
//            mapView.addAnnotation([p1, p2]) Not needed?
            self.mapView.addOverlay(route.polyline)
            self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), animated: true)
            
            // Set Direction Steps
            self.directions = route.steps.map { $0.instructions }.filter { !$0.isEmpty }
        }
    }
}

extension MapViewModel: AnnotationSelectionDelegate {
    
    func selectedAnnotation(_ annotation: MKAnnotation) {
        selectedAnnotation = annotation
    }
}

struct Place: Identifiable {
    var id = UUID().uuidString
    var place: CLPlacemark
}


struct MapView: View {
    
//    @State private var directions = [String]()
    @State private var showDirections = false
    @StateObject var mapData = MapViewModel()
    @State var locationManager = CLLocationManager()
    
    var body: some View {
        VStack {
            ZStack {
                
                MapViewContent(directions: $mapData.directions)
                    .environmentObject(mapData)
                    .ignoresSafeArea(.all, edges: .all)
                
                VStack {
                    searchBarView
                    
                    Spacer()
                }
                
                
            }
            .sheet(isPresented: $showDirections) {
                VStack {
                    Text("Directions")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    Divider().background(.blue)
                    
                    List {
                        ForEach(0..<mapData.directions.count, id: \.self) { i in
                            Text(mapData.directions[i])
                                .padding()
                        }
                    }
                }
            }
            .onAppear(perform: {
                locationManager.delegate = mapData
                locationManager.requestWhenInUseAuthorization()
            })
            .alert(isPresented: $mapData.permissionDenied, content: {
                Alert(
                    title: Text("Permission Denied"),
                    message: Text("Please Enable Permission In App Settins"),
                    dismissButton: .default(Text("Go To Settings"),
                                            action: {
                                                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                                            }))
            })
            .onChange(of: mapData.searchText, perform: { value in
                
                let delay = 0.3
                
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    
                    if value == mapData.searchText {
                        self.mapData.searchQuery()
                    }
                }
            })
        }
        
        Button {
            self.showDirections.toggle()
        } label: {
            Text("Show Directions")
        }
        .disabled(mapData.directions.isEmpty)
        .padding()

    }
    
    var searchBarView: some View {
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Search", text: $mapData.searchText)
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(.white)
            
            if !mapData.places.isEmpty && !mapData.searchText.isEmpty {
                searchResultsView
            }
        }
        .padding()
    }
    
    var searchResultsView: some View {
        ScrollView {
            VStack(spacing: 15) {
                ForEach(mapData.places) { place in
                    Text(place.place.name ?? "")
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        .onTapGesture {
                            mapData.selectPlace(place: place)
                        }
                    
                    Divider()
                }
            }
            .padding(.top)
        }
        .background(.white)
    }
}

struct MapViewContent: UIViewRepresentable {
    
    @Binding var directions: [String]
    @EnvironmentObject var mapData: MapViewModel
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator(annotationDelegate: mapData)
    }
    
    func makeUIView(context: Context) -> some UIView {
        let view = mapData.mapView
        view.showsUserLocation = true
        view.delegate = context.coordinator
        
//        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
//        view.setRegion(mapData.region, animated: true)
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
//        let mapView = MKMapView()
//        mapView.delelgate = context.coordinator
        let view = mapData.mapView
        view.delegate = context.coordinator
    }
    
    class MapViewCoordinator: NSObject, MKMapViewDelegate {
        
        weak var annotationDelegate: AnnotationSelectionDelegate?
        
        init(annotationDelegate: AnnotationSelectionDelegate) {
            self.annotationDelegate = annotationDelegate
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            // Custom Pins....
            
            // Excluding User Blue Circle
            
            if annotation.isKind(of: MKUserLocation.self) { return nil }
            
            let pinAnnotation = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "PIN_VIEW")
            pinAnnotation.tintColor = .red
            pinAnnotation.animatesWhenAdded = true
            pinAnnotation.canShowCallout = true
            
            return pinAnnotation
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKMultiPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .blue
            renderer.lineWidth = 5
            return renderer
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            guard
                let annotation = view.annotation,
                annotation.isKind(of: MKUserLocation.self) == false else { return }
            
            annotationDelegate?.selectedAnnotation(annotation)
        }
    }
    
}

protocol AnnotationSelectionDelegate: AnyObject {
    
    func selectedAnnotation(_ annotation: MKAnnotation)
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
