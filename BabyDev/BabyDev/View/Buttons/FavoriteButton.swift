//
//  FavoriteButton.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 19.05.2023.
//

import SwiftUI

struct FavoriteButton: View {
    
    @State var isFavorite: Bool = JobListViewModel().favorite
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            withAnimation(.linear(duration: 0.7)) {
                isFavorite.toggle()
                action()
            }
        })
        {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .resizable()
                .frame(width: 25, height: 22)
                .foregroundColor(isFavorite ? Color.lightPurple : Color.black.opacity(0.6))
        }
    }
}
