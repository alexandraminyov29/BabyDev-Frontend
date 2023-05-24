//
//  FilterTab.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 25.05.2023.
//

import SwiftUI

struct FilterTab: View {
    
    @State var text: String
    
    var body: some View {
        NavigationLink(
            destination: HomePage(url: Constants.filteredJobsURL, filter: text)
                .padding(.top, 40)
        ) {
            HStack {
                Text(text)
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

