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
             try await fetchUserToDos()
        }
    }
    
    func fetchUserToDos() async throws {
        guard let id = UserService.shared.currentUser?.id else { return }
        self.todos = try await ToDoService.shared.fetchUserToDos(by: id )
    }
    
    func deleteToDo(at offsets: IndexSet) async throws{
        guard let first = offsets.first else { return }
        guard let id = self.todos[first].id else {return }
        try await ToDoService.shared.deleteToDo(id: id)
        self.todos.remove(atOffsets: offsets)
    }
   
}


