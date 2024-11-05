//
//  EditToDoView.swift
//  ToDo
//
//  Created by Tomas Elordi on 05/11/2024.
//

import SwiftUI


struct CreateEditToDoView: View {
    @State var viewModel: CreateEditToDoViewModel
    @Environment(\.dismiss) var dismiss
    init(todo: ToDo,typeAction: TypeAction) {
        self.viewModel = CreateEditToDoViewModel(todo: todo,typeAction:typeAction)
    }
    var body: some View {
        @Bindable var viewModelBindable = viewModel
        if TypeAction.create == viewModel.typeAction {
            Text("Create ToDo").font(.title)
                .fontWeight(.bold)
                .padding(.top,16)
        }
        Form{
            Section{
                TextField("Title", text: $viewModelBindable.title)
                    .autocorrectionDisabled()
                TextField("Description", text: $viewModelBindable.description)
                    .autocorrectionDisabled()
                
            }
            Section{
                HStack{
                    Text("Done")
                    Spacer()
                    Toggle(isOn: $viewModelBindable.done, label: {
                        viewModel.done ? Image(systemName: "checkmark.circle.fill") : Image(systemName: "circle")
                    }).toggleStyle(.button)
                }
                if viewModel.hasDueDate {
                    DatePicker("Due Date", selection: $viewModelBindable.dueDate)
                        .datePickerStyle(.graphical)
                    Button{
                        viewModelBindable.hasDueDate = false
                    }label: {
                        Text("Remove Due Date")
                    }
                }else{
                    Button{
                        viewModelBindable.hasDueDate = true
                    }label: {
                        Text("Set Due Date")
                    }
                }
                Button{
                    Task{
                        if viewModel.typeAction == .create{
                            try await viewModel.createToDo()
                        }
                        if viewModel.typeAction == .edit{
                            try await viewModel.updateToDo()
                        }
                        dismiss()
                    }
                }label: {
                    Text("Save")
                    
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                .foregroundStyle(.white)
                .fontWeight(.semibold)
                .font(.title3)
            }
        }
    }
}

#Preview {
    var todo: ToDo = ToDo(title: "Hello world", done: true)
    CreateEditToDoView(todo: todo, typeAction: .create)
}

