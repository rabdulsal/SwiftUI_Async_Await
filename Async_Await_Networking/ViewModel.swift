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
            case .success(let users):
                DispatchQueue.main.async {
                    self.users = users
                }
            case .failure(let error): throw error
            }
        } catch {
            throw error
        }
    }
    
}

//struct Interactor {
//  var httpClient: HTTPClient
//  var users: [User]
//  func getUsers() -> throw {
//
//     = try await httpClient.getUsers { result in
//    switch result:
//
//    case (.failure)let error:
//
//    case (.success)let users:
//          self.users = users
//
//  }
//  }
//}

struct Genre: Codable {
  let main: String
  let secondary: String
}


enum NetworkError : String, Error {
    case badURL = "Could not create proper URL"
    case cannotDecodeData = "Could not decode data"
    case failedResponse = ""
}

struct HTTPClient {
  
    let appID = "64bb43351a9f5c51ac1d89aa" // To be sent with all network calls
    
//    func getUser() async throws -> Result<User, Error> {
//
//    }
    
    func getUsers() async throws -> Result<[UserPreview], Error> { // Result<[User], error>
      
       let endpoint = "https://dummyapi.io/data/v1/user?limit=10"
        
    //    let url = URL(string: endpoint)

    //  let task = URLSession.shared.dataTask(with: url) { data, response, error in
    //        if let error = error {
    //            completion(data,response,error)
    //            return
    //        }
    //        guard let data = data, httpResponse = response as? HTTPURLResponse,
    //            (200...299).contains(httpResponse.statusCode) else {
    //            completion(data,response,error)
    //            return
    //        }
    //        // if let mimeType = httpResponse.mimeType, mimeType == "text/html",
    //        //     let data = data,
    //        //     let string = String(data: data, encoding: .utf8) {
    //        //     DispatchQueue.main.async {
    //        //         self.webView.loadHTMLString(string, baseURL: url)
    //        //     }
    //        // }
    //                                                    completion(data,response,nil)
    //    }
    //    task.resume()
         guard let url = URL(string: endpoint) else {
             throw NetworkError.badURL
         }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(self.appID, forHTTPHeaderField: "app-id")
        let (data, response) = try await URLSession.shared.data(for: request)
          
     //       Result([],error)
     //     }
      
    //       AF.request(url: url) { data, response, error
          
                              
    //     }
    //
         guard
            let res = response as? HTTPURLResponse,
                res.statusCode == 200 else {

             throw NetworkError.failedResponse
         }

         do {
             let userList = try JSONDecoder().decode(UserListData.self, from: data)
             return .success(userList.data)
         } catch {
             return .failure(NetworkError.cannotDecodeData)
         }
        // JSONDecoder().decode

      }
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
