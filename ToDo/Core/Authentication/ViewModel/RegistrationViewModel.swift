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
    
    func createUser() async throws {
        try await AuthService.shared.signUp(email: email, password: password, username: username, fullname: fullname)
    }
}
