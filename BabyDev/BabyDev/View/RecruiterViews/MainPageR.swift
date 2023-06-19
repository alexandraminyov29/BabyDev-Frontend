//
//  MainPageR.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 18.06.2023.
//

import SwiftUI

struct MainPageR: View {
    
    @State private var selection: Int = 1
    
    var body: some View {
        TabView(selection: $selection) {
            HomePageRecruiter()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(0)
            RecruiterProfile()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(1)
        }
        .navigationBarBackButtonHidden(true)
        .tint(Color.lightPurple)
        .onAppear {
            selection = 0
        }
    }
}
