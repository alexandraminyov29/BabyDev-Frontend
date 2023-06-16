//
//  newfile.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 16.05.2023.
//

import SwiftUI

struct MainPage: View {
    
    @State private var selection: Int = 1
    
    var body: some View {
        TabView(selection: $selection) {
            HomePage(url: Constants.allJobsURL)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(0)
            RecommendedJobs()
                .tabItem {
                    Image(systemName: "heart.text.square.fill")
                    Text("Job board")
                }
                .tag(1)
          
            Profile()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(2)
        }
        .navigationBarBackButtonHidden(true)
        .tint(Color.lightPurple)
        .onAppear {
            selection = 0
        }
    }
}

