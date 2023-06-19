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
                                    destination: HomePage(url: Constants.filteredByCityURL, filter: loc.uppercased(), hasLocationFilterApplied: true)
                                        .padding(.top, 40)
                                ) {
                                    UIFactory.shared.makeFilterTab(from: loc.uppercased())
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
    
    // GENERATED WITH CHAT GPT
    let city = [
        "Iasi",
        "Arad",
        "Pitesti",
        "Bacau",
        "Oradea",
        "Bistrita",
        "Botosani",
        "Brasov",
        "Braila",
        "Buzau",
        "Resita",
        "Cluj-Napoca",
        "Constanta",
        "Sfantu Gheorghe",
        "Targu Mures",
        "Craiova",
        "Piatra Neamt",
        "Targu Jiu",
        "Deva",
        "Slobozia",
        "Suceava",
        "Alexandria",
        "Timisoara",
        "Tulcea",
        "Vaslui",
        "Ramnicu Valcea",
        "Focsani",
        "Galati",
        "Giurgiu",
        "Miercurea Ciuc",
        "Slatina",
        "Ploiesti",
        "Zalau",
        "Sibiu",
        "Calarasi",
        "Satu Mare",
        "Sighetu Marmatiei",
        "Drobeta-Turnu Severin",
        "Radauti"
    ]

}

