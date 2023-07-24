//
//  UserDetailsViewModel.swift
//  Async_Await_Networking
//
//  Created by Rashad Abdul-Salam on 7/24/23.
//

import Foundation


class UserDetailsViewModel: ObservableObject {
    
    @Published var user: User?
    private var networkService = HTTPClient()
    
    init(user: User? = nil, networkService: HTTPClient = HTTPClient()) {
        self.user = user
        self.networkService = networkService
    }
    
    func getUser(with id: String) async throws {
        
        do {
            let result = try await self.networkService.getUser(id: id)
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.user = user
                }
            case .failure(let error): throw error
            }
        } catch {
            throw error
        }
        
    }
}
