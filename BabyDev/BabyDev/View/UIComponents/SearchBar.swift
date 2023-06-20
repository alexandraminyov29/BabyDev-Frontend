//
//  SearchBar.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 08.05.2023.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(.leading, 20)
            Image(systemName: "magnifyingglass")
                .padding(.trailing, 15)
        }
        .frame(height: 40)
        .background(Color.white.opacity(0.9))
        .cornerRadius(10)
        .padding(.horizontal, 16)
        .shadow(color: Color.black.opacity(0.7), radius: 10)
    }
}

