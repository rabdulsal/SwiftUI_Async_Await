//
//  OrdersListViewModel.swift
//  Async_Await_Networking
//
//  Created by Abdul-Salaam, Rashad (Penske, Insight Global) on 9/25/23.
//

import Foundation

class OrdersListViewModel: ObservableObject {
    @Published var orders = [OrderItem]()
    @Published var ordersFetchError = ""
    
    private var networkingService = OrdersNetworkingService()
    
    func getOrdersList(pageSize: Int = 10) async {
        do {
            let result = try await self.networkingService.getOrders()
            
            switch result {
            case .success(let ordersList):
                DispatchQueue.main.async {
                    self.orders = ordersList.data
                }
            case .failure(let error): throw error
            }
        } catch {
            self.ordersFetchError = error.localizedDescription
        }
    }
}
