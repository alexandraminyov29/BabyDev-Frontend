//
//  Profile.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 28.05.2023.
//

import SwiftUI

struct Profile: View {
    
    @State private var titleText: String = ""
    @State var userModel: [PersonalDetailsModel] = []
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundS
                VStack {
                    personalDetails
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private var personalDetails: some View {
        PersonalDetails()
    }
    
    private var backgroundS: some View {
        Color.profilePageBG
            .ignoresSafeArea(.all)
            .opacity(0.6)
    }
}

