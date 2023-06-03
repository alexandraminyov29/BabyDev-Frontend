//
//  SaveButton.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 29.05.2023.
//

import SwiftUI

struct SaveButton: View {
    
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            withAnimation(.linear(duration: 0.7)) {
                action()
            }
        }) {
            HStack {
                Text("Save")
                Image(systemName: "checkmark")
            }
            .padding(.all, 9)
            .foregroundColor(.white)
            .background(Color.lightPurple.clipShape(Capsule()))
        }
    }
}
