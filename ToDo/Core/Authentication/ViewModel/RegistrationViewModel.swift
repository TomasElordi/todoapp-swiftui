//
//  RegistrationViewModel.swift
//  ToDo
//
//  Created by Tomas Elordi on 06/11/2024.
//

import Foundation
import SwiftUI

@Observable
class RegistrationViewModel{

    var email: String = ""
    var password: String = ""
    var fullname: String = ""
    var username: String = ""
    
    var alert: Bool = false
    var errorMessage: String?
    
    func createUser() async throws {
        if email.isEmpty || password.isEmpty || username.isEmpty || fullname.isEmpty {
            alert = true
            errorMessage = "All fields are required"
            return
        }
        do{
            try await AuthService.shared.signUp(email: email, password: password, username: username, fullname: fullname)
        }catch{
            alert = true
            errorMessage = error.localizedDescription
        }
        
    }
}
