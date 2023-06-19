//
//  EditJobButton.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 19.06.2023.
//

import SwiftUI

struct EditJobButton: View {
    
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            withAnimation(.linear(duration: 0.7)) {
                action()
            }
        }) {
            HStack {
                Text("Save job")
                    .bold()
                    .font(.title3)
                Image(systemName: "checkmark.seal.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
            }
            .foregroundColor(.white)
            .padding(.all, 7)
            .frame(width: 400, height: 50)
            .background(Color.lightPurple.clipShape(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5))))
            
        }
    }
}
