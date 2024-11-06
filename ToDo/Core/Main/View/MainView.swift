//
//  ContentView.swift
//  ToDo
//
//  Created by Tomas Elordi on 04/11/2024.
//

import SwiftUI

struct MainView: View {
    @State var viewModel: MainViewModel = MainViewModel()
    
    var body: some View {
        @Bindable var viewModelBindable = viewModel
        NavigationStack{
            List {
                ForEach($viewModelBindable.todos) { $todo in
                    NavigationLink(destination:{
                        CreateEditToDoView(todo: todo, typeAction: .edit).navigationTitle("Edit ToDo").navigationBarTitleDisplayMode(.inline)
                            .onDisappear{
                                Task{
                                    try await viewModel.fetchToDos()
                                }
                            }
                    },label:{
                        ToDoDetailsView(todo: $todo)
                    })
                }
                .onDelete(perform: {offset in
                    Task{
                       try await viewModel.deleteToDo(at: offset)
                    }
                })
            }
            
            .refreshable {
                Task{
                    try await viewModel.fetchToDos()
                }
            }
            
            
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        viewModel.showAddTodo = true
                    }label:{
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $viewModelBindable.showAddTodo, onDismiss: {
                Task{
                    try await viewModel.fetchToDos()
                }
            }, content: {
                CreateEditToDoView(todo: ToDo(title: "", done: false),typeAction: .create)
            })
            .navigationTitle("To-Do")
        }
        
    }
}

#Preview {
   MainView()
}
