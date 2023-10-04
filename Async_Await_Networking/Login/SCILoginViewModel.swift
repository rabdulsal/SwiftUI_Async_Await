//
//  SCILoginViewModel.swift
//  Async_Await_Networking
//
//  Created by Abdul-Salaam, Rashad (Penske, Insight Global) on 9/28/23.
//

import Foundation

class SCILoginViewModel: ObservableObject {
    
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
