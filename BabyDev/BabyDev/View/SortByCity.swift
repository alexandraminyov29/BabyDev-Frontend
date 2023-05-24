//
//  SortByCity.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 24.05.2023.
//

import SwiftUI

struct SortByCity: View {
    
    @State var searchText: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.homePageBG
                VStack {
                    SearchBar(text: $searchText)
                    ScrollView {
                        LazyVStack {
                            ForEach(city, id: \.self) { loc in
                                UIFactory.shared.makeFilterTab(from: loc)
                            }
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    var city = ["Bucuresti", "Cluj", "Timisoara", "Iasi", "Constanta", "Craiova", "Brasov", "Galati", "Ploiesti", "Oradea", "Braila", "Arad", "Pitesti", "Sibiu", "Bacau", "Buzau", "Botosani"]
}

