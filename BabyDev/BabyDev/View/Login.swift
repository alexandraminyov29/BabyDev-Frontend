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
    @StateObject private var vm = LoginVM()
    
    var body: some View {
        NavigationView {
            ZStack {
                Colors().backgroundColor.edgesIgnoringSafeArea(.all)
                VStack {
                    Image("logonegru")
                        .padding(.top, -250)
                    title
                    content
                    loginButton
                    
                }
            }
        }
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
            SeparatorView()
            SecureField("Password",text: $person.password)
                .cornerRadius(5.0)
                .padding(.horizontal, 50)
            SeparatorView()
        }
    }
    
    private var loginButton: some View {
        Button("Sign In") {
            vm.login(person: person)
        }
        .padding()
        .foregroundColor(.white)
        .background(Colors().purple.clipShape(Capsule()))
        .padding(.top, 30)
    }


}
