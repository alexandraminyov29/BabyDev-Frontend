//
//  SeeApplicantsButton.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 20.06.2023.
//

import SwiftUI

struct SeeApplicantsButton: View {
    
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            withAnimation(.linear(duration: 0.7)) {
                action()
            }
        }) {
            HStack {
                Text("See aplicants")
                Image(systemName: "arrow.up.forward.circle.fill")
            }
            .padding(.all, 7)
            .frame(width: 150)
            .foregroundColor(.white)
            .background(Color.lightPurple.clipShape(Capsule()))
        }
    }
}
