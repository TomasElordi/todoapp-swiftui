//
//  TabBarView.swift
//  ToDo
//
//  Created by Tomas Elordi on 06/11/2024.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView{
            MainView()
                .tabItem{
                    Image(systemName: "checklist")
                }
            ProfileView()
                .tabItem{
                    Image(systemName: "person")
                }
        }
    }
}

#Preview {
    TabBarView()
}
