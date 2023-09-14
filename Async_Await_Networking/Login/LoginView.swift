//
//  LoginView.swift
//  Async_Await_Networking
//
//  Created by Rashad Abdul-Salaam on 9/11/23.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    
    @Published var username = ""
    @Published var password = ""
    
}

struct LoginView: View {
    
    @StateObject var loginVM = LoginViewModel()
    @Binding var isSignedIn: Bool
    
    var body: some View {
        
        NavigationView {
//            VStack(spacing: 8) {
            Form {
                TextField("SSO ID", text: $loginVM.username)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                SecureField("Password", text: $loginVM.password)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                
                Button {
                    self.loginPenskeUser()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                        
                        Text("Login")
                            .foregroundColor(.white)
                            .bold()
                    }
                }
                
            }
        }
    }
    // TODO: 1. Move to LoginViewModel, 2. Add validations logic etc in VM
    func loginPenskeUser() {
        // Set 'isSignedIn' so MainView can update
        isSignedIn = true
    }
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isSignedIn: .constant(false))
    }
}
