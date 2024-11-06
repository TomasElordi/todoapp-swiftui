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
    
    @MainActor
    func login() async throws{
        try await AuthService.shared.signIn(email: email, password: password)
    }
}
