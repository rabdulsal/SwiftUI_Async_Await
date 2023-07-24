//
//  HTTPClient.swift
//  Async_Await_Networking
//
//  Created by Rashad Abdul-Salam on 7/22/23.
//

import Foundation

protocol NetworkRequestable {
    
    var endpoint: String { get set }
}

extension NetworkRequestable {
    var appIDHeader: String { return "64bb43351a9f5c51ac1d89aa" }
    
    func fetchData<T: Codable>(of type: T.Type) async throws -> Result<T,Error> {
        
        guard let url = URL(string: self.endpoint) else {
            throw NetworkError.badURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(self.appIDHeader, forHTTPHeaderField: "app-id")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            return try self.handleRequestResponse(data, response, for: T.self)
        } catch {
            throw error
        }
    }
    
    func handleRequestResponse<T:Codable>(_ data: Data, _ response: URLResponse, for type: T.Type) throws -> Result<T,Error> {
        
        guard let res = response as? HTTPURLResponse, (200...299).contains(res.statusCode) else {
            throw NetworkError.failedResponse
        }
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedData)
        } catch {
            throw error
        }
    }
}

enum NetworkError : String, Error {
    case badURL = "Could not create proper URL"
    case cannotDecodeData = "Could not decode data"
    case failedResponse = ""
}


struct HTTPClient: NetworkRequestable {
    
    var endpoint = "https://dummyapi.io/data/v1/user?limit=10"
    
    func getUsers() async throws -> Result<UserListData, Error> {
        
        return try await self.fetchData(of: UserListData.self)
    }
}
