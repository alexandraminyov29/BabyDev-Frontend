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
                jobType
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private var city: some View {
        NavigationLink( destination: SortByCity()) {
            UIFactory.shared.makeFilterTab(from: "City")
        }
    }
    
    private var jobType: some View {
        NavigationLink( destination: SortByJobType()) {
            UIFactory.shared.makeFilterTab(from: "Job type")
        }
    }
}

