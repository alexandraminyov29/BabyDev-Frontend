//
//  Register.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 06.03.2023.
//

import SwiftUI
import UIKit

struct Register: View {
    
    @State private var titleText: String = ""
    @State private var person = RegisterModel()
    @StateObject private var vm = RegisterVM()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.gray.edgesIgnoringSafeArea(.all)
                VStack {
                    Image("logoalb")
                        .padding(.top, -350)
                    title
                    content
                    
                }
            }
        }

    }
    
    private var title: some View {
        Text("\(titleText)")
            .font(.title)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.6)) {
                    titleText = "Register"
                }
            }
        
    }
    private var content: some View {
        VStack(alignment: .center) {
            
            TextField("First Name", text: $person.first_name)
                .cornerRadius(5.0)
                .padding(.horizontal, 50)
            
            TextField("Last Name", text: $person.last_name)
                .cornerRadius(5.0)
                .padding(.horizontal, 50)
            
            TextField("E-mail", text: $person.email)
                .cornerRadius(5.0)
                .padding(.horizontal, 50)
            
            SecureField("Password",text: $person.password)
                .cornerRadius(5.0)
                .padding(.horizontal, 50)
        
            TextField("Phone Number",text: $person.phone_number)
                .cornerRadius(5.0)
                .keyboardType(.numberPad)
                .padding(.horizontal, 50)
        }
    }
}

