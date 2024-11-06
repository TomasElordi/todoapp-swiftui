//
//  ProfileView.swift
//  ToDo
//
//  Created by Tomas Elordi on 06/11/2024.
//

import SwiftUI

struct ProfileView: View {
    
    @State var viewModel: ProfileViewModel = ProfileViewModel()
    
    var body: some View {
        VStack{
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .padding()
            
            
            if let user = viewModel.user {
                Text(user.fullname)
                    .font(.headline)
                    .truncationMode(.tail)
                    .padding()
                    .foregroundColor(.secondary)
                Text(user.email)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .truncationMode(.tail)
            }
            Button{
                Task{
                    try await viewModel.signOut()
                }
            }label:{
                Text("Sign Out").font(.headline)
                    .foregroundColor(.red)
                    .padding()
                    .lineLimit(1)
                    
                
            }
        }
    }
}

#Preview {
    ProfileView()
}
