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
                                    try await viewModel.fetchUserToDos()
                                }
                            }
                    },label:{
                        ToDoDetailsView(todo: $todo)
                    })
                }
                .onDelete(perform: {offset in
                    Task{
                        try await viewModel.deleteToDo(at: offset)
                        try await viewModel.fetchUserToDos()
                    }
                })
            }
            
            .refreshable {
                Task{
                    try await viewModel.fetchUserToDos()
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
                    try await viewModel.fetchUserToDos()
                }
            }, content: {
                CreateEditToDoView(todo: nil,typeAction: .create)
            })
            .navigationTitle("To-Do")
        }
        
    }
}

#Preview {
    MainView()
}
