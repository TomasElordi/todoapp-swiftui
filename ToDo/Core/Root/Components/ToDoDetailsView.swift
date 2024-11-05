//
//  ToDoDetails.swift
//  ToDo
//
//  Created by Tomas Elordi on 05/11/2024.
//

import SwiftUI

struct ToDoDetailsView: View {
    @Binding var todo: ToDo
    var body: some View {
        HStack(alignment: .center, spacing: 8){
            Toggle(isOn: $todo.done) {
                Image(systemName: todo.done ? "checkmark.circle" : "circle")
            }.toggleStyle(.button)
            
            VStack(alignment: .leading, spacing: 0) {
                Text(todo.title).font(.headline).fontWeight(.medium)
                if let description = todo.description{
                    if(!description.isEmpty){
                        Text(description).font(.footnote).fontWeight(.light)
                    }
                }
            }
            
            Spacer()
            if let dueDate = todo.dueDate{
                VStack(alignment: .trailing,spacing: 0){
                    Text("\(dueDate.formatted().prefix(10))")
                        .font(.caption).fontWeight(.light)
                        .padding(.bottom, 2)
                    
                    Text("\(dueDate.formatted().suffix(8))")
                        .font(.caption).fontWeight(.light)
                        
                        .padding(.bottom, 2)
                }.foregroundStyle(todo.dueDate?.timeIntervalSinceNow ?? 1 < 0 ? .red : .gray)
            }
        }
    }
}

#Preview {
    @Previewable @State var todo: ToDo = ToDo(title: "Hello", description: "World", done: true, dueDate: Date())
    ToDoDetailsView(todo: $todo)
}
