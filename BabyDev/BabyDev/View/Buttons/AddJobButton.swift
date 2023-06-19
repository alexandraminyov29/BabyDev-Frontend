//
//  AddJobButton.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 18.06.2023.
//

import SwiftUI

struct AddJobButton: View {
    
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            withAnimation(.linear(duration: 0.7)) {
                action()
            }
        }) {
            HStack {
                Text("Add job")
                    .bold()
                    .font(.title3)
                Image(systemName: "plus.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            .foregroundColor(.white)
            .padding(.all, 7)
            .frame(width: 400, height: 50)
            .background(Color.lightPurple.clipShape(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5))))
            
        }
    }
}
