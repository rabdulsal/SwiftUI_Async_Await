//
//  SearchTextField.swift
//  Async_Await_Networking
//
//  Created by Rashad Abdul-Salam on 8/19/23.
//

import SwiftUI

struct SearchTextField: View {
    @EnvironmentObject var mapData: MapViewModel
    @FocusState private var searchIsFocused: Bool
//    @Binding private var searchIsFocused: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search", text: $mapData.searchText)
                        .focused($searchIsFocused)
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
        .onSubmit {
            searchIsFocused = false
        }
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
                            searchIsFocused = false
                        }
                    
                    Divider()
                }
            }
            .padding(.top)
        }
        .background(.white)
    }
}

struct SearchTextField_Previews: PreviewProvider {
    static var previews: some View {
        SearchTextField()
    }
}
