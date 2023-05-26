//
//  BackButton.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 26.05.2023.
//

import SwiftUI

struct BackButton<Destination>: View where Destination: View {
    
    let destination: Destination
        
    var body: some View {
        NavigationLink(destination: destination) {
            HStack(alignment: .top) {
                Image(systemName: "chevron.backward")
                Text("Back")
            }
            .padding()
        }
    }
}



