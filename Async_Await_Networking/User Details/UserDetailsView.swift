//
//  UserDetailsView.swift
//  Async_Await_Networking
//
//  Created by Rashad Abdul-Salam on 7/24/23.
//

import SwiftUI

struct UserDetailsView: View {
    
    @ObservedObject var viewModel = UserDetailsViewModel()
    var userID: String
    
    var body: some View {
        
        // Main Container
        VStack {
            // User Minor Details
            VStack(spacing: 10) {
                // Image
                AsyncImage(url: URL(string: viewModel.user?.picture ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                } placeholder: {
                    Circle()
                        .background(.gray)
                }
                .frame(width: 120, height: 120)
                
                // Content
                
                Text("\(viewModel.user?.firstName ?? "") \(viewModel.user?.lastName ?? "")")
                    .font(.title)
                Text("\(viewModel.user?.gender ?? "male")")
                    .foregroundColor(.secondary)
                Text("Member ID: \(viewModel.user?.id ?? "")")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                //                    Text("Member since: \(viewModel.user?.registerDate ?? "")")
            }
            
            Divider()
                .padding(.vertical,8)
            
                VStack(alignment: .leading, spacing: 10) {
                    Text("Contact Info:")
                        .bold()
                    Text("E: \(viewModel.user?.email ?? "")")

                    Text("P: \(viewModel.user?.phone ?? "")")
                }
            
            Spacer()
        }
        .padding()
        .task {
            do {
                try await viewModel.getUser(with: userID)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailsView(userID: "60d0fe4f5311236168a109ca")
    }
}
