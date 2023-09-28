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
    @Published var loginSuccessful = false
    
    func loginUser() async -> Bool {
        
        if username.isEmpty {
            usernameErrorMessage = "Username cannot be empty."
        } else if username.lowercased() != "505064424" {
            usernameErrorMessage = "Username is not correct."
        } else {
            usernameErrorMessage = ""
        }
        
        if password.isEmpty {
            passwordErrorMessage = "Password cannot be empty."
        } else if password.lowercased() != "password" {
            passwordErrorMessage = "Password is not correct."
        } else {
            passwordErrorMessage = ""
        }
        
        if usernameErrorMessage.isEmpty && passwordErrorMessage.isEmpty {
            loginSuccessful = true
        }
        return loginSuccessful
    }
}
 
extension Color {
    
    static let penskeDarkBlue = Color(red: 5.0 / 255.0, green: 50.0 / 255.0, blue: 92.0 / 255.0)
    
    static let penskeTeal = Color(red: 8.0 / 102.0, green: 139.0 / 255.0, blue: 92.0 / 255.0)
}

struct LoginView: View {
    
    @StateObject var loginVM = LoginViewModel()
    @Binding var isSignedIn: Bool
    @State var isLoggingInUser = false
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading, spacing: 8) {
                
                Image("penske_logo_banner")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                VStack(alignment: .leading) {
                    if !loginVM.usernameErrorMessage.isEmpty {
                        Text(loginVM.usernameErrorMessage)
                            .foregroundColor(.red)
                    }
                    
                    if !loginVM.passwordErrorMessage.isEmpty {
                        Text(loginVM.passwordErrorMessage)
                            .foregroundColor(.red)
                    }
                }
                .padding(.horizontal)
                
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
                    .foregroundColor(.penskeDarkBlue)
                    .frame(height: 50)
                }
            }
            .background(Color(white: 0.95))
            Spacer()
        }
    }
    // TODO: 1. Move to LoginViewModel, 2. Add validations logic etc in VM
    func loginPenskeUser() {
        // Set 'isSignedIn' so MainView can update
        isLoggingInUser = true
        Task {
            isSignedIn = await loginVM.loginUser()
            isLoggingInUser = false
        }
    }
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isSignedIn: .constant(false))
    }
}
