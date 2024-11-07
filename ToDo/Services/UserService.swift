//
//  UserService.swift
//  ToDo
//
//  Created by Tomas Elordi on 06/11/2024.
//

import Foundation
import Supabase
class UserService {
    @Published var currentUser: User?
    
    static let shared = UserService()
    
    init(){
        Task{
            try await fetchCurrentUser()
        }
    }
    
    func fetchCurrentUser() async throws -> User?{
        let emailUser = Supabase.anonymousClient.auth.currentUser?.email
        let response = try await Supabase.anonymousClient.from("users").select("*").eq("email",value: emailUser).single().execute()
        
        let decoder = JSONDecoder()
        if let user = try? decoder.decode(User.self, from: response.data){
            self.currentUser = user
            return user
        }else{
            print("Error decoding user")
        }
        return nil
    }
    
    func createUser(username: String, email:String, fullname: String) async throws{
        let user = User(username: username, email: email, fullname: fullname)
        try await Supabase.anonymousClient.from("users").insert(user).execute()
        
        try await fetchCurrentUser()
    }
    
    func reset(){
        currentUser = nil
    }
}
