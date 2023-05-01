//
//  ContentView.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 13.02.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            if AuthenticationManager.shared.shouldAskForLogin() {
                StartPage()
            } else {
                HomePage()
            }
        }
    }
}
