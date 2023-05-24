//
//  ApplyButton.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 22.05.2023.
//

import SwiftUI

struct ApplyButton: View {
    
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            withAnimation(.linear(duration: 0.7)) {
                action()
            }
        }) {
            HStack {
                Text("Apply")
                Image(systemName: "arrow.up.forward.circle.fill")
            }
            .padding(.all, 7)
            .foregroundColor(.white)
            .background(Color.lightPurple.clipShape(Capsule()))
        }
    }
}

