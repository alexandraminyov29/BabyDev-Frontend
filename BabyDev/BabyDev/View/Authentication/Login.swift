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
    @State private var shouldNavigateRecruiter = false
    @State private var shouldNavigateAdmin = false
    @State private var shouldShowAlert = false
    @StateObject private var vm = LoginVM()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundColor.edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer(minLength: .zero)
                    Image("logonegru")
                        .resizable()
                        .scaledToFit()
                        .padding(.top, -250)
                    title
                        .scaledToFit()
                    Spacer(minLength: .zero)
                    content
                    loginButton
                    Spacer(minLength: .zero)
                    registerButton
                    
                }
            }
        }

        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    private var title: some View {
        Text("\(titleText)")
            .font(Font.custom("Times New Roman", size: CGFloat(35)))
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
        .padding(.top, -130)
    }
    
    private var loginButton: some View {
        Button("Sign In") {
            vm.login (
                person: person,
                shouldNavigate: $shouldNavigate,
                shouldNavigateRecruiter: $shouldNavigateRecruiter,
                shouldNavigateAdmin: $shouldNavigateAdmin, shouldShowAlert: $shouldShowAlert
                    )
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
                
            }.tint(Color.purple1)
        }
        .padding(.top, -50)
        .background(
            NavigationLink(
                destination: MainPage(),
                isActive: $shouldNavigate
            ) {
                EmptyView()
            }
                .hidden()
        )
        .background(
            NavigationLink(
                destination: MainPageR(),
                isActive: $shouldNavigateRecruiter
            ) {
                EmptyView()
            }
                .hidden()
        )
        .background(
            NavigationLink(
                destination: AdminDashboard(),
                isActive: $shouldNavigateAdmin
            ) {
                EmptyView()
            }
                .hidden()
        )
            .alert(isPresented: $shouldShowAlert) {
                Alert(
                    title: Text("OOPS..."),
                    message: Text("Your credentials are invalid!").font(.title3),
                    dismissButton: .default(Text("OK"))
                    )
            }

    }
    
    private var selectRole: Bool {
        if shouldNavigate {
            return shouldNavigate
        } else if shouldNavigateRecruiter {
            return shouldNavigateRecruiter
        } else if shouldNavigateAdmin {
            return shouldNavigateAdmin
        }
        return false
    }
}
