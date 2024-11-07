//
//  RegistrationView.swift
//  ThreadsTutorial
//
//  Created by Tomas Elordi on 29/10/2024.
//

import SwiftUI

struct RegistrationView: View {
    
    @State var viewModel: RegistrationViewModel = RegistrationViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        @Bindable var viewModelBindable = viewModel
        
        VStack{
            Spacer()
            Image("todo-app-icon")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .padding()
            
            VStack{
                TextField("Enter your email", text: $viewModelBindable.email)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                    .modifier(ToDoTextFieldModifier())
                SecureField("Enter your password", text: $viewModelBindable.password)
                    .modifier(ToDoTextFieldModifier())
                TextField("Enter your fullname", text: $viewModelBindable.fullname)
                    .modifier(ToDoTextFieldModifier())
                TextField("Enter your username", text: $viewModelBindable.username)
                    .textInputAutocapitalization(.never)
                    .modifier(ToDoTextFieldModifier())
               
            }
            Button{
                Task{
                    try await viewModel.createUser()
                }
            }label:{
                Text("Sign up")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width:352,height: 44)
                    .background(.blue)
                    .cornerRadius(8)
            }.padding(.vertical)
            Spacer()
            Divider()
            
            Button{
                dismiss()
            }label:{
                HStack(spacing:3){
                    Text("Already have an account?")
                    Text("Sign in")
                        .fontWeight(.semibold)
                }
                .foregroundStyle(.blue)
                .font(.footnote)
            }
            
            
        }.alert(viewModel.errorMessage ?? "", isPresented: $viewModelBindable.alert){
            Button("OK", role: .cancel){}
        }
    }
}

#Preview {
    RegistrationView()
}
