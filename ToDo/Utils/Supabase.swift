//
//  Supabase.swift
//  ToDo
//
//  Created by Tomas Elordi on 06/11/2024.
//

import Foundation
import Supabase

class Supabase {
    
    static var userClient : SupabaseClient?
    static let anonymousClient = SupabaseClient(supabaseURL: URL(string: Constants.apiURL)!, supabaseKey: Constants.annonKey)
    
}
