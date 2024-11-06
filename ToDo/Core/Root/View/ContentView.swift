//
//  ContentView.swift
//  ToDo
//
//  Created by Tomas Elordi on 06/11/2024.
//

import SwiftUI

struct ContentView: View {
    @State var viewModel: ContentViewModel = ContentViewModel()
    
    var body: some View {
        Group{
            if viewModel.userSession != nil {
                withAnimation(.easeIn(duration: 300)){
                    TabBarView()
                }
            }else{
                withAnimation(.easeOut(duration: 300)){
                    LoginView()
                }
            }
            
            
            
        }
    }
}

#Preview {
    ContentView()
}
