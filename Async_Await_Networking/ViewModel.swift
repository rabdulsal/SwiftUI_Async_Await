//
//  ViewModel.swift
//  Async_Await_Networking
//
//  Created by Rashad Abdul-Salam on 7/21/23.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var users = [UserPreview]()
    private var networkingService = HTTPClient()
    
    convenience init(users: [UserPreview] = [UserPreview](), networkingService: HTTPClient = HTTPClient()) {
        self.init()
        self.users = users
        self.networkingService = networkingService
    }
    
    func getUsers() async throws {
        do {
            let result = try await self.networkingService.getUsers()
            
            switch result {
            case .success(let userListData):
                DispatchQueue.main.async {
                    self.users = userListData.data
                }
            case .failure(let error): throw error
            }
        } catch {
            throw error
        }
    }
    
}

struct Genre: Codable {
  let main: String
  let secondary: String
}



// 2. If we had to group users by director, how would that be achieved?

//let users = [User]()
//
//let nonNilUsers = users.filter { $0.director != nil }
//
//let usersDict : [String: Set<Users>]
//
//for user in nonNilUsers {
//
//  if var users = usersDict[user.director] {
//    users.insert(user)
//  } else {
//    usersDict[user.director] = [user]
//  }
//}
