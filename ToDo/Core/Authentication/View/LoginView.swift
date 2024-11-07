//
//  LoginView.swift
//  ThreadsTutorial
//
//  Created by Tomas Elordi on 29/10/2024.
//

import SwiftUI

struct LoginView: View {
    
    @State var viewModel: LoginViewModel = LoginViewModel()
    
    var body: some View {
        @Bindable var viewModelBindable = viewModel
        NavigationStack{
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
                }
                
                NavigationLink{
                    Text("Forgot password?")
                }label:{
                    Text("Forgot password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.vertical)
                        .padding(.trailing,28)
                        .foregroundStyle(.blue)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                Button{
                    Task{
                      try await viewModel.login()
                    }
                }label:{
                    Text("Login")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width:352,height: 44)
                        .background(.blue)
                        .cornerRadius(8)
                }
                Spacer()
                
                Divider()
                
                NavigationLink{
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                }label:{
                    HStack(spacing:3){
                        Text("Don't have and account?")
                        Text("Sign up")
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(.blue)
                    .font(.footnote)
                }
            }
            .alert(viewModel.errorMessage ?? "", isPresented: $viewModelBindable.alert){
                Button("OK",role: .cancel){}
            }
        }
    }
}

#Preview {
    LoginView()
}
