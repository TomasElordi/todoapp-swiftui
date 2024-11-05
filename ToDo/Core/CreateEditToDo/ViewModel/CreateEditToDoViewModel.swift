//
//  EditToDoViewModel.swift
//  ToDo
//
//  Created by Tomas Elordi on 05/11/2024.
//

import Foundation

@Observable
class CreateEditToDoViewModel {
    
    
    var todo: ToDo
    var title: String
    var description: String
    var done: Bool
    var dueDate: Date
    var hasDueDate: Bool
    var typeAction: TypeAction
    
    init(todo: ToDo,typeAction: TypeAction){
        self.todo = todo
        self.title = todo.title
        if let description = todo.description{
            self.description = description
        }else{
            self.description = ""
        }
        self.done = todo.done
        if let dueDate = todo.dueDate{
            self.dueDate = dueDate
        }else{
            self.dueDate = Date()
        }
        self.hasDueDate = todo.dueDate != nil
        self.typeAction = typeAction
        
    }
    
    func fetchToDo(id: Int) async throws{
        self.todo = try await ToDoService.shared.fetchToDo(id: id)
    }
    func createToDo() async throws {
        try await ToDoService.shared.createToDo(title: title, description: description, done: done, dueDate: dueDate)
    }
    
    func updateToDo() async throws {
        guard let id = todo.id else { return }
        print("Update to do view model id: \(id)")
        try await ToDoService.shared.updateToDo(id: id, title: title, description: description, done: done, dueDate: dueDate)
    }
}

enum TypeAction{
    case edit
    case create
}
