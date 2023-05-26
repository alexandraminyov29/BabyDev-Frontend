//
//  SortByCity.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 24.05.2023.
//

import SwiftUI

struct SortByCity: View {
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.homePageBG
                    .padding(.top, -30)
                VStack {
                    ScrollView {
                        LazyVStack {
                            ForEach(city, id: \.self) { loc in
                                NavigationLink(
                                    destination: HomePage(url: Constants.filteredByCityURL, filter: loc, hasLocationFilterApplied: true)
                                        .padding(.top, 40)
                                ) {
                                    UIFactory.shared.makeFilterTab(from: loc)
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
    
    var city = ["Bucuresti", "Cluj", "Timisoara", "Iasi", "Constanta", "Craiova", "Brasov", "Galati", "Ploiesti", "Oradea", "Braila", "Arad", "Pitesti", "Sibiu", "Bacau", "Buzau", "Botosani"]
}

