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
                Color.backgroundColor.edgesIgnoringSafeArea(.all)
                VStack(alignment: .center, spacing: .zero) {
                    Image("startApp")
                        .resizable()
                           .scaledToFit()
                        .padding(.top, -120)
                    welcomeMessage
                        .scaledToFit()
                    VStack(spacing: .zero) {
                        registerButton
                        loginButton
                    }
                    .padding(.top, 100)
                }
                .padding(.bottom, -20)
            }
        }
    }
    
    private var welcomeMessage: some View {
        VStack(spacing: .zero) {
            Text("Welcome to BabyDev!")
                .font(Font.custom("Times New Roman", size: CGFloat(50)))
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                .padding(.bottom, 50)
            Text("Take your first baby steps of your jurney to success!")
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                .font(Font.custom("Times New Roman", size: CGFloat(25)))
        }
    }
    
    private var registerButton: some View {
        NavigationLink(destination: Register(),
                                      isActive: $isLinkActive) {
                           Text("Create account")
                .foregroundColor(isLinkActive ? .white : Color.purple1)
                               .padding()
                               .background(isLinkActive ? Color.purple1 : Color.white)
                               .cornerRadius(10)
                               .overlay(
                                   RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.purple1, lineWidth: 2)
                               )
                       }
                       .buttonStyle(PlainButtonStyle())
                       .padding(.bottom, 20)
    }
    
    private var loginButton: some View {
        HStack(spacing: 7) {
            Text("Already have an account?")
                .font(.custom("Times New Roman", size: 18))
            NavigationLink("Sign In", destination: Login())
                .tint(Color.purple1)
        }
    }
}
