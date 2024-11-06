//
//  ContentViewModel.swift
//  ToDo
//
//  Created by Tomas Elordi on 04/11/2024.
//

import Foundation
import Supabase
@Observable
class MainViewModel {
    
    var todos = [ToDo]()
    var showAddTodo: Bool = false
    
    init(){
        Task{
             try await fetchToDos()
        }
    }
    
    func fetchToDos() async throws {
        self.todos = try await ToDoService.shared.fetchToDos()
    }
    
    func deleteToDo(at offsets: IndexSet) async throws{
        guard let first = offsets.first else { return }
        guard let id = self.todos[first].id else {return }
        try await ToDoService.shared.deleteToDo(id: id)
        self.todos.remove(atOffsets: offsets)
    }
   
}


