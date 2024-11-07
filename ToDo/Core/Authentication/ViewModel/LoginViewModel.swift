//
//  LoginViewModel.swift
//  ThreadsTutorial
//
//  Created by Tomas Elordi on 30/10/2024.
//

import Foundation
import SwiftUI

@Observable
class LoginViewModel {
    
    var email = ""
    var password = ""
    
    var alert: Bool = false
    var errorMessage: String?
    
    @MainActor
    func login() async throws{
        do {
            if (email.isEmpty && password.isEmpty){
                errorMessage = "Please enter email and password"
                alert = true
                return
            }
            if(email.isEmpty ){
                errorMessage = "Please enter email"
                alert = true
                return
            }
            if(password.isEmpty ){
                errorMessage = "Please enter password"
                alert = true
                return
            }
            try await AuthService.shared.signIn(email: email, password: password)
        }
        catch {
            errorMessage = error.localizedDescription
            alert = true
        }
    }
}
