//
//  StartPage.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 26.03.2023.
//

import SwiftUI

struct StartPage: View {
    @State private var isLinkActive = false
    var body: some View {
        NavigationView {
            ZStack {
                Colors().backgroundColor.edgesIgnoringSafeArea(.all)
                VStack(spacing: .zero) {
                    Image("startApp")
                        .padding(.top, -250)
                    welcomeMessage
                    HStack(spacing: .zero) {
                        registerButton
                        loginButton
                    }
                }
            }
        }
    }
    
    private var welcomeMessage: some View {
        VStack(spacing: .zero) {
            Text("Welcome to BabyDev")
                .font(Font.custom("Times New Roman", size: 35))
                .padding(.bottom, 20)
            Text("Take your first baby steps of your jurney to success!")
                .multilineTextAlignment(.center)
                .font(Font.custom("Times New Roman", size: 20))
        }
    }
    
    private var registerButton: some View {
        NavigationLink(destination: Register(),
                                      isActive: $isLinkActive) {
                           Text("Create account")
                .foregroundColor(isLinkActive ? .white : Colors().purple)
                               .padding()
                               .background(isLinkActive ? Colors().purple : Color.white)
                               .cornerRadius(10)
                               .overlay(
                                   RoundedRectangle(cornerRadius: 10)
                                    .stroke(Colors().purple, lineWidth: 2)
                               )
                       }
                       .buttonStyle(PlainButtonStyle())
    }
    
    private var loginButton: some View {
        Text("")
    }
}

