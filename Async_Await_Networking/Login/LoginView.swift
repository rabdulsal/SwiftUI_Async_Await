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
    @Published var usernameErrorMessage = ""
    @Published var passwordErrorMessage = ""
    
    
    func loginUser() {
        
    }
}

struct LoginView: View {
    
    @StateObject var loginVM = LoginViewModel()
    @Binding var isSignedIn: Bool
    @State var isLoggingInUser = false
    
    var body: some View {
        
        NavigationView {
//            VStack(spacing: 8) {
            Form {
                if !loginVM.usernameErrorMessage.isEmpty {
                    Text(loginVM.usernameErrorMessage)
                }
                TextField("SSO ID", text: $loginVM.username)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                if !loginVM.passwordErrorMessage.isEmpty {
                    Text(loginVM.passwordErrorMessage)
                }
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
        isLoggingInUser = true
        isSignedIn = true
    }
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isSignedIn: .constant(false))
    }
}
