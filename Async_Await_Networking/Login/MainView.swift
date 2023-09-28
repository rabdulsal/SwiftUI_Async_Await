//
//  MainView.swift
//  Async_Await_Networking
//
//  Created by Rashad Abdul-Salaam on 9/14/23.
//

import SwiftUI

class MainViewModel: ObservableObject {
    
    @Published var isSignedIn = false
}

struct MainView: View {
    
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        
        if viewModel.isSignedIn {
            OrdersListView()
        } else {
            LoginView(isSignedIn: $viewModel.isSignedIn)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
