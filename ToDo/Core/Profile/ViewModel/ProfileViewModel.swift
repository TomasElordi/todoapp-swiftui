//
//  ProfileViewModel.swift
//  ToDo
//
//  Created by Tomas Elordi on 06/11/2024.
//

import Foundation


@Observable
class ProfileViewModel {
    
    
    var user: User?
    
    init(){
        Task{
            try await fetchUser()
        }
    }
    
    func fetchUser() async throws{
        self.user = try await UserService.shared.fetchCurrentUser()
    }
    
    
    func signOut() async throws{
        try await AuthService.shared.signOut()
    }
}
