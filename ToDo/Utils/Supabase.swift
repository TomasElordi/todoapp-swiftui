//
//  Supabase.swift
//  ToDo
//
//  Created by Tomas Elordi on 06/11/2024.
//

import Foundation
import Supabase

class Supabase {
    
    static let client = SupabaseClient(
        supabaseURL: URL(string: Constants.apiURL)!,
        supabaseKey: Constants.annonKey
    )
}
