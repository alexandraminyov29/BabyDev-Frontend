//
//  DeclineButton.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 20.06.2023.
//

import SwiftUI

struct DeclineButton: View {
    
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            withAnimation(.linear(duration: 0.7)) {
                action()
            }
        }) {
            HStack {
                Image(systemName: "trash")
                    .resizable()
                    .frame(width: 20, height: 22)
                    .foregroundColor(.lightPurple)
            }
        }
    }
}
