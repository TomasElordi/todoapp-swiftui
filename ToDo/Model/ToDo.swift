//
//  ToDo.swift
//  ToDo
//
//  Created by Tomas Elordi on 04/11/2024.
//

import Foundation
import Supabase

struct ToDo: Codable, Identifiable {
    
    var id: Int?
    var title: String
    var description: String?
    var done: Bool
    var dueDate: Date?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case done
        case dueDate = "due_date"
    }
}
