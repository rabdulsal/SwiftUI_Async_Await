//
//  ContentView.swift
//  Async_Await_Networking
//
//  Created by Rashad Abdul-Salam on 7/21/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = HomeViewModel()
    
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.users, id: \.self) { user in
                    HStack(spacing: 20.0) {
                       
                        AsyncImage(url: URL(string: user.picture)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(Circle())
                        } placeholder: {
                            Circle()
                                .foregroundColor(.secondary)
                        }
                        .frame(width: 60, height: 60)
                        
                        VStack(alignment: .leading) {
                            Text(user.id)
                                .foregroundColor(.secondary)
                                .font(.caption)
                            Text("\(user.title) \(user.firstName) \(user.lastName)")
                                .foregroundColor(.primary)
                        }
                        Spacer()
                    }
                }
            }
        }
        .padding()
        .task {
            // Fetch data
            do {
                try await viewModel.getUsers()
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = HomeViewModel(users: UserListData.mockUsers)
        ContentView(viewModel: viewModel)
    }
}
