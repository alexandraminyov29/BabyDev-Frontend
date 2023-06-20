//
//  StarRating.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 29.05.2023.
//

import SwiftUI

struct StarRating: View {
    
    @State var ratingNumber: Int
    
    var body: some View {
        HStack {
            Image(systemName: ratingNumber < 1 ? "star" : "star.fill")
                .foregroundColor(Color.yellow)
            Image(systemName: ratingNumber < 2 ? "star" : "star.fill")
                .foregroundColor(Color.yellow)
            Image(systemName: ratingNumber < 3 ? "star" : "star.fill")
                .foregroundColor(Color.yellow)
            Image(systemName: ratingNumber < 4 ? "star" : "star.fill")
                .foregroundColor(Color.yellow)
            Image(systemName: ratingNumber < 5 ? "star" : "star.fill")
                .foregroundColor(Color.yellow)
        }
    }
}

struct ModifyStarRating: View {
    @State var ratingNumber: Int
    
    var body: some View {
        HStack {
            Button(action: {
                ratingNumber = 1
            }) {
                Image(systemName: ratingNumber < 1 ? "star" : "star.fill")
                    .foregroundColor(Color.yellow)
            }
            
            Button(action: {
                ratingNumber = 2
            }) {
                Image(systemName: ratingNumber < 2 ? "star" : "star.fill")
                    .foregroundColor(Color.yellow)
            }
            Button(action: {
                ratingNumber = 3
            }) {
                Image(systemName: ratingNumber < 3 ? "star" : "star.fill")
                    .foregroundColor(Color.yellow)
            }
            Button(action: {
                ratingNumber = 4
            }) {
                Image(systemName: ratingNumber < 4 ? "star" : "star.fill")
                    .foregroundColor(Color.yellow)
            }
            Button(action: {
                ratingNumber = 5
            }) {
                Image(systemName: ratingNumber < 5 ? "star" : "star.fill")
                    .foregroundColor(Color.yellow)
            }
            
        }
    }
}
