//
//  AuthService.swift
//  ToDo
//
//  Created by Tomas Elordi on 06/11/2024.
//

import Foundation
import Supabase

class AuthService {
    
    @Published var userSession: Session?
    
    static let shared = AuthService()
    
    
    private let supabase = SupabaseClient(
        supabaseURL: URL(string: Constants.apiURL)!,
        supabaseKey: Constants.annonKey
    )
    
    init(){
        Task{
           try await getSession()
        }
    }
    
    func signUp(email: String, password: String,username: String, fullname: String) async throws {
        do{
            let authResponse = try await supabase.auth.signUp(email: email, password: password)
            try await UserService.shared.createUser(username: username, email: email, fullname: fullname)
            self.userSession = authResponse.session
        }catch{
            print("ERROR: \(error)")
        }
        
    }
    
    func signIn(email: String, password: String) async throws {
        userSession =  try await supabase.auth.signIn(email: email, password: password)
    }
    
    func signOut() async throws {
        do{
            try await supabase.auth.signOut()
            UserService.shared.reset()
        }catch{
            print("ERROR: \(error)")
        }
        userSession = nil
    }
    
    func getSession() async throws {
        do{
            let session = try await supabase.auth.session
            self.userSession = session
        }catch{
            self.userSession = nil
        }
        
    }
   
}
