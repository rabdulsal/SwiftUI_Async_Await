//
//  SCIMainMapListView.swift
//  Async_Await_Networking
//
//  Created by Rashad Abdul-Salam on 10/5/23.
//

import SwiftUI

struct SCIMainMapListView: View {
    @State private var selectedCard = 0
    @State private var offset: CGFloat = 0
    @State private var isMapViewActive = true // Initially, map view is active
    @State private var isListViewVisible = false
    
    var body: some View {
        ZStack(alignment: .top) {
            
            // Content View Toggle
            if isMapViewActive {
                SCIMainMapView()
                    .edgesIgnoringSafeArea(.all)
            } else {
                ZStack(alignment: .bottom) {
                    // Darkened MapView in the Background
                    SCIMainMapView()
                        .edgesIgnoringSafeArea(.all)
                        .opacity(0.5)
                    
                    // Vertical ListView
                    if isListViewVisible {
                        ScrollView {
                            VStack(spacing: 16) {
                                ForEach(0..<10, id: \.self) { index in
                                    CardView(index: index)
                                        .frame(width: UIScreen.main.bounds.width - 32, height: 200) // Adjust card size as needed
                                }
                            }
                            .padding(.horizontal, 16)
                        }
                        .transition(.move(edge: .bottom))
                        .animation(.easeInOut(duration: 0.3))
                        .padding(.top, 50)
                        .offset(x: offset)
//                        .gesture(
//                            DragGesture()
//                                .onChanged { value in
//                                    offset = value.translation.width - CGFloat(selectedCard) * UIScreen.main.bounds.width
//                                }
//                                .onEnded { value in
//                                    let cardWidth = UIScreen.main.bounds.width - 32
//                                    let newIndex = Int((offset + value.predictedEndTranslation.width) / cardWidth)
//                                    selectedCard = min(max(newIndex, 0), 9)
//                                    withAnimation {
//                                        offset = CGFloat(selectedCard) * -cardWidth
//                                    }
//                                }
//                        )
                    }
                }
                .onAppear() {
                    withAnimation {
                        isListViewVisible = true
                    }
                }
                
            }
            
            HStack {
                Spacer()
                
                // Toggle Button (Segment Control)
                SCIMapListPicker(isMapViewActive: $isMapViewActive)
            }
        }
        .onAppear() {
            // Preload data or perform any setup here
        }
    }
}

struct SCIMapListPicker: View {
    
    @Binding var isMapViewActive: Bool
    
    init(isMapViewActive: Binding<Bool>) {
        UISegmentedControl.appearance().selectedSegmentTintColor = .white
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        UISegmentedControl.appearance().backgroundColor = .black
        self._isMapViewActive = isMapViewActive
    }
    
    var body: some View {
        Picker(selection: $isMapViewActive, label: Text("")) {
            Image(systemName: isMapViewActive ? "map.fill" : "map").tag(true)
            //                Image(systemName: isMapViewActive ? "list.bullet" : "map").tag(false)
            Image(systemName: "list.bullet").tag(false)
        }
        .frame(width: 100)
        .pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal, 16)
    }
}

struct CardView: View {
    let index: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color.white)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
            
            Text("Card \(index + 1)")
                .font(.title)
                .padding()
        }
    }
}

struct SCIMainMapView: View {
    var body: some View {
        // Your MapView content here
        Text("Map View")
            .font(.title)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.red)
    }
}

struct SCIMainMapListView_Previews: PreviewProvider {
    static var previews: some View {
        SCIMainMapListView()
    }
}
