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
        supabaseURL: URL(string: "http://localhost:8000")!,
        supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyAgCiAgICAicm9sZSI6ICJhbm9uIiwKICAgICJpc3MiOiAic3VwYWJhc2UtZGVtbyIsCiAgICAiaWF0IjogMTY0MTc2OTIwMCwKICAgICJleHAiOiAxNzk5NTM1NjAwCn0.dc_X5iR_VP_qT0zsiyj_I_OZ2T9FtRU2BBNWN8Bu4GE"
    )
    
    
    func fetchToDos()async throws -> [ToDo] {
        do{
            let todos : [ToDo] = try await supabase.from("todos").select("*").execute().value
            print("TODOS: \(todos)")
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
        print("update to do service: \(id) \(title) ")
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
