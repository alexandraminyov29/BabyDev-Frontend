//
//  Login.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 25.03.2023.
//

import SwiftUI

struct Login: View {
    
    @State private var titleText: String = ""
    @State private var person = LoginModel()
    @State private var shouldNavigate = false
    @StateObject private var vm = LoginVM()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundColor.edgesIgnoringSafeArea(.all)
                VStack {
                    Image("logonegru")
                        .padding(.top, -250)
                    title
                    content
                    loginButton
                    registerButton
                    
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    private var title: some View {
        Text("\(titleText)")
            .font(Font.custom("Times New Roman", size: 35))
            .foregroundColor(.black)
            .padding(.top, -50)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.6)) {
                    titleText = "Login"
                }
            }
    }

    private var content: some View {
        VStack(alignment: .center) {
            TextField("E-mail", text: $person.email)
                .cornerRadius(5.0)
                .padding(.horizontal, 50)
                .autocapitalization(.none)
            SeparatorView()
            SecureField("Password",text: $person.password)
                .cornerRadius(5.0)
                .padding(.horizontal, 50)
            SeparatorView()
        }
    }
    
    private var loginButton: some View {
        Button("Sign In") {
            vm.login(person: person, shouldNavigate: $shouldNavigate)
        }
        .padding()
        .foregroundColor(.white)
        .background(Color.purple1.clipShape(Capsule()))
        .padding(.top, 30)
    }
    
    private var registerButton: some View {
        HStack(spacing: 7) {
            Text("Don't you have an account?")
            NavigationLink(destination: Register()) {
                Label("Sign Up", systemImage: "arrow.right.circle")
                
            }
        }
        .padding(.top, 50)
        .background(
            NavigationLink(
                destination: HomePage(),
                isActive: $shouldNavigate
            ) {
                EmptyView()
            }
                .hidden()
        )
    }
}
