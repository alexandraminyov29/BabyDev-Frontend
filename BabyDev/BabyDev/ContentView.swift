//
//  ContentView.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 13.02.2023.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        if UserDefaults.standard.string(forKey: "token") == nil {
            StartPage()
        } else {
            if UserDefaults.standard.string(forKey: "role") == "ADMIN" {
                AdminDashboard()
            } else if UserDefaults.standard.string(forKey: "role") == "RECRUITER" {
                MainPageR()
            } else if UserDefaults.standard.string(forKey: "role") == "STANDARD" {
                MainPage()
            } else {
                Login()
            }
        }
    }
}
