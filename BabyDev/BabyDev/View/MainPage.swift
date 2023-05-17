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
            Register()
                .tabItem {
                    Image(systemName: "map")
                    Text("map")
                }
                .tag(0)
            HomePage()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(1)
            StartPage()
                .tabItem {
                    Image(systemName: "map")
                    Text("map")
                }
                .tag(2)
        }
        .tint(Color.purple1)
        .onAppear {
            selection = 1
        }
    }
}

