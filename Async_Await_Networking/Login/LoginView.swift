//
//  LoginView.swift
//  Async_Await_Networking
//
//  Created by Rashad Abdul-Salaam on 9/11/23.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    
    @State var username = ""
    @State var password = ""
    
}

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        
        VStack(spacing: 8) {
            TextField(text: $viewModel.username) {
                Text("SSO ID")
            }
            .padding()
            
            TextField(text: $viewModel.password) {
                Text("Password")
            }
            .padding()
            
            
            Button("Login") {
                // TODO: Fire method to pass username & password
                self.loginPenskeUser()
            }
            
        }
    }
    
    func loginPenskeUser() {
        // TODO: For now just push to RoutesListView
    }
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
