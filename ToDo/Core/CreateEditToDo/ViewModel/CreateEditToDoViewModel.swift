//
//  EditToDoViewModel.swift
//  ToDo
//
//  Created by Tomas Elordi on 05/11/2024.
//

import Foundation

@Observable
class CreateEditToDoViewModel {
    
    
    var todo: ToDo?
    var title: String
    var description: String
    var done: Bool
    var dueDate: Date
    var hasDueDate: Bool
    var typeAction: TypeAction
    
    var alert: Bool = false
    var errorMessage: String?
    
    init(todo: ToDo?,typeAction: TypeAction){
       
        if let todo = todo{
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
            
        }else{
            self.todo = nil
            self.title = ""
            self.description = ""
            self.done = false
            self.dueDate = Date()
            self.hasDueDate = false
        }
        self.typeAction = typeAction
    }
    
    func fetchToDo(id: Int) async throws{
        do{
            self.todo = try await ToDoService.shared.fetchToDo(id: id)
        }catch{
            alert = true
            errorMessage = error.localizedDescription
        }
    }
    func createToDo() async throws {
        do{
            guard let id = UserService.shared.currentUser?.id else { return }
            if(title.isEmpty){
                errorMessage = "Title is required"
                alert = true
                throw ErrorThrow.unknownError
            }
            try await ToDoService.shared.createToDo(title: title, description: description, done: done, dueDate: hasDueDate ? dueDate : nil,userId: id)
        }catch let error as ErrorThrow  {
            throw error
        }catch{
            alert = true
            errorMessage = error.localizedDescription
            throw error
        }
       
    }
    
    func updateToDo() async throws {
        do{
            if(title.isEmpty){
                errorMessage = "Title is required"
                alert = true
                throw ErrorThrow.unknownError
            }
            guard let id = todo?.id else { return }
            guard let userId = todo?.userId else { return }
            try await ToDoService.shared.updateToDo(id: id, title: title, description: description, done: done, dueDate: hasDueDate ? dueDate : nil, userId: userId)
        }catch{
            alert = true
            errorMessage = error.localizedDescription
            throw error
        }
       
    }
}

enum TypeAction{
    case edit
    case create
}
