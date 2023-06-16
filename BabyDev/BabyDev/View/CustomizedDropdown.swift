//
//  CustomizedDropdown.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 08.06.2023.
//

import SwiftUI

struct CustomizedDropdown: View {
    
    var showDropdown: Bool
    
    var body: some View {
        VStack {
            VStack {
                NavigationLink(destination: FavoriteJobs()) {
                    Text("Favorite jobs")
                        .font(.title2)
                        .bold()
                        .padding(.trailing, 15)
                        .foregroundColor(.black)
                }
                Divider()
                    .frame(width: 250, height: 2)
                NavigationLink(destination: AppliedJobs()) {
                    Text("Applied jobs")
                        .font(.title2)
                        .bold()
                        .padding(.trailing, 15)
                        .foregroundColor(.black)
                }
                Divider()
                    .frame(width: 250, height: 2)
                NavigationLink(destination: RecommendedJobs()) {
                    Text("Suggestions")
                        .font(.title2)
                        .bold()
                        .padding(.trailing, 15)
                        .foregroundColor(.black)
                }
            }
            .padding(.vertical, 10)
            .background(Color.white.brightness(2))
            .cornerRadius(10)
        }
        .padding(.top, -350)
        .padding(.leading, 75)
    }
}

