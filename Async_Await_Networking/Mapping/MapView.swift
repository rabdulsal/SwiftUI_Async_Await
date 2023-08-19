//
//  MapView.swift
//  Async_Await_Networking
//
//  Created by Rashad Abdul-Salam on 7/22/23.
//

import SwiftUI
import MapKit


struct Place: Identifiable {
    var id = UUID().uuidString
    var place: CLPlacemark
}


struct MapView: View {
    
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
                directionsSheetUI
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
            ZStack {
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search", text: $mapData.searchText)
                }
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background(.white)
                .cornerRadius(6)
                .shadow(color: .black, radius: 8)
                
            }
            
            Divider()
            
            // Search Results
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
    
    var directionsSheetUI: some View {
        VStack {
            Text("Directions")
                .font(.largeTitle)
                .bold()
                .padding()
            
            List {
                ForEach(0..<mapData.directions.count, id: \.self) { i in
                    Text(mapData.directions[i])
                        .padding()
                }
            }
        }
    }
    
    var mappingDirectionsButton: some View {
        
        // Mapping Directions button
        Button {
//            mapData.makeDirections()
        } label: {
            Image(systemName: "map")
        }
//        .disabled(mapData.selectedAnnotation == nil)
        .padding(.trailing)
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
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {

    }
    
    class MapViewCoordinator: NSObject, MKMapViewDelegate {
        
        weak var annotationDelegate: AnnotationSelectionDelegate?
        
        init(annotationDelegate: AnnotationSelectionDelegate) {
            self.annotationDelegate = annotationDelegate
        }
        
        // MARK: - Delegates
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            self.annotationDelegate?.updateMapView(with: region)
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
            let renderer = MKPolylineRenderer(overlay: overlay)
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
        
        // MARL: - Helpers
        
        func updateMapView(withPlace: Place) {
            
        }
    }
}

protocol AnnotationSelectionDelegate: AnyObject {
    
    func selectedAnnotation(_ annotation: MKAnnotation)
    func updateMapView(with region: MKCoordinateRegion)
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
