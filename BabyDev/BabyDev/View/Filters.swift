//
//  FilterBar.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 24.05.2023.
//

import SwiftUI

struct Filters: View {
        
    var body: some View {
        NavigationView {
            VStack {
                city
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private var city: some View {
        NavigationLink( destination: SortByCity()) {
            HStack() {
                Text("City")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                Spacer(minLength: CGFloat(50))
                Image(systemName: "arrow.up")
                    .foregroundColor(Color.white)
            }
            .padding(.horizontal, 30)
            .frame(width: 400, height: 50)
            .background(Color.lightPurple)
            .clipShape(RoundedRectangle(cornerRadius: 10 ,style: .circular))
        }
    }
}

