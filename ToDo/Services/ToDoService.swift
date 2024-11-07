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
    
    
    func fetchToDos() async throws -> [ToDo] {
        do{
            let todos : [ToDo] = try await Supabase.anonymousClient.from("todos").select("*").order("due_date", ascending: false).execute().value
            return todos
        }catch{
            print("DEBUGLOG: \(error)")
            throw error
        }
        
    }
    
    func fetchUserToDos(by userId: Int) async throws -> [ToDo] {
        do{
            let todos : [ToDo] = try await Supabase.anonymousClient.from("todos").select("*").eq("user_id", value: userId).order("due_date", ascending: false).execute().value
            return todos
        }catch{
            print("DEBUGLOG: \(error)")
            throw error
        }
        
    }
    
    func createToDo(title: String, description: String?, done: Bool?,dueDate: Date?, userId: Int) async throws{
        do{
            let todo : ToDo = ToDo(title: title, description: description, done: done ?? false, dueDate: dueDate, userId: userId)
            try await Supabase.anonymousClient.from("todos").insert(todo).execute()
        }catch{
            print("DEBUGLOG: \(error)")
            throw error
        }
    }
    
    func updateToDo(id: Int,title: String, description: String?, done: Bool?,dueDate: Date?, userId: Int) async throws{
        do{
            let todo : ToDo = ToDo( title: title, description: description, done: done ?? false, dueDate: dueDate, userId: userId)
            try await Supabase.anonymousClient.from("todos").update(todo).eq("id", value: "\(id)").execute()
        }catch{
            print("DEBUGLOG: \(error)")
            throw error
        }
    }
    
    func fetchToDo(id: Int) async throws -> ToDo{
        do{
            let todo : ToDo = try await Supabase.anonymousClient.from("todos").select("*").eq("id", value: "\(id)").execute().value
            return todo
        }catch{
            print("DEBUGLOG: \(error)")
            throw error
        }
    }
    
    func deleteToDo(id: Int) async throws{
        do{
            try await Supabase.anonymousClient.from("todos").delete().eq("id", value: "\(id)").execute()
        }catch{
            print("DEBUGLOG: \(error)")
            throw error
        }
    }
}
