//
//  SortByJobType.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 26.05.2023.
//

import SwiftUI

struct SortByJobType: View {
    
    var jobType = ["Part_time", "Full_time", "Internship"]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.homePageBG
                    .padding(.top, -30)
                VStack {
                    backButton
                    ScrollView {
                        LazyVStack {
                            ForEach(jobType, id: \.self) { type in
                                NavigationLink(
                                    destination: HomePage(url: Constants.filteredByTypeURL, jobType: type, hasJobTypeFilterApplied: true)
                                        .padding(.top, 40)
                                ) {
                                    UIFactory.shared.makeFilterTab(from: type.replacing("_", with: " "))
                                }
                            }
                        }
                    }
                }
                .padding(.top, 70)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private var backButton: some View {
        UIFactory.shared.makeBackButton(destination: Filters())
            .padding(.top, -20)
            .padding(.trailing, 320)
            .shadow(color: .black, radius: 20)
    }
}
