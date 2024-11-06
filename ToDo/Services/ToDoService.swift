//
//  ToDoService.swift
//  ToDo
//
//  Created by Tomas Elordi on 04/11/2024.
//

import Foundation
import Supabase
class ToDoService {
    
    static let shared = ToDoService()
    
    private let supabase = SupabaseClient(
        supabaseURL: URL(string: Constants.apiURL)!,
        supabaseKey: Constants.annonKey
    )
    
    
    func fetchToDos()async throws -> [ToDo] {
        do{
            let todos : [ToDo] = try await supabase.from("todos").select("*").order("due_date", ascending: false).execute().value
            return todos
        }catch{
            print("DEBUGLOG: \(error)")
            throw error
        }
        
    }
    
    func createToDo(title: String, description: String?, done: Bool?,dueDate: Date?) async throws{
        do{
            let todo : ToDo = ToDo(title: title, description: description, done: done ?? false, dueDate: dueDate)
            try await supabase.from("todos").insert(todo).execute()
        }catch{
            print("DEBUGLOG: \(error)")
            throw error
        }
    }
    
    func updateToDo(id: Int,title: String, description: String?, done: Bool?,dueDate: Date?) async throws{
        do{
            let todo : ToDo = ToDo( title: title, description: description, done: done ?? false, dueDate: dueDate)
            try await supabase.from("todos").update(todo).eq("id", value: "\(id)").execute()
        }catch{
            print("DEBUGLOG: \(error)")
            throw error
        }
    }
    
    func fetchToDo(id: Int) async throws -> ToDo{
        do{
            let todo : ToDo = try await supabase.from("todos").select("*").eq("id", value: "\(id)").execute().value
            return todo
        }catch{
            print("DEBUGLOG: \(error)")
            throw error
        }
    }
    
    func deleteToDo(id: Int) async throws{
        do{
            try await supabase.from("todos").delete().eq("id", value: "\(id)").execute()
        }catch{
            print("DEBUGLOG: \(error)")
            throw error
        }
    }
}
