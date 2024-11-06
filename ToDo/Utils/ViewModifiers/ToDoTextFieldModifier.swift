//
//  ToDoTextFieldModifier.swift
//  ToDo
//
//  Created by Tomas Elordi on 06/11/2024.
//

import SwiftUI

struct ToDoTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding(12)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal,24)
    }
}
