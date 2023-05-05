//
//  Register.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 06.03.2023.
//

import SwiftUI

struct Register: View {
    
    @State private var titleText: String = ""
    @State private var person = RegisterModel()
    @State private var shouldNavigate = false
    @StateObject private var vm = RegisterVM()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundColor.edgesIgnoringSafeArea(.all)
                VStack {
                    Image("logonegru")
                        .padding(.top, -250)
                    title
                    content
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
                    titleText = "Register"
                }
            }
    }
    private var content: some View {
        VStack(alignment: .center) {
            TextField("First Name", text: $person.firstName)
                .cornerRadius(5.0)
                .padding(.horizontal, 50)
            SeparatorView()
            TextField("Last Name", text: $person.lastName)
                .cornerRadius(5.0)
                .padding(.horizontal, 50)
            SeparatorView()
            TextField("E-mail", text: $person.email)
                .textInputAutocapitalization(.none)
                .cornerRadius(5.0)
                .padding(.horizontal, 50)
                .autocapitalization(.none)
            SeparatorView()
            SecureField("Password",text: $person.password)
                .cornerRadius(5.0)
                .padding(.horizontal, 50)
            SeparatorView()
            TextField("Phone number", text: $person.phoneNumber)
                .keyboardType(.decimalPad)
                .cornerRadius(5.0)
                .padding(.horizontal, 50)
            SeparatorView()
        }
    }
    
    private var registerButton: some View {
        Button("Sign Up") {
            vm.createAccount(person: person, shouldNavigate: $shouldNavigate)
        }
        .padding()
        .foregroundColor(.white)
        .background(Color.purple.clipShape(Capsule()))
        .padding(.top, 30)
        .background(
            NavigationLink(
                destination: Login(),
                isActive: $shouldNavigate
            ) {
                EmptyView()
            }
                .hidden()
        )
    }
}

