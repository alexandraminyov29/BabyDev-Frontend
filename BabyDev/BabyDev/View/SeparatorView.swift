//
//  SeparatorView.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 13.03.2023.
//

import SwiftUI

struct SeparatorView: View {
    var body: some View {
        Divider()
            .frame(height: 1)
            .background(
                LinearGradient(
                    colors: [ Colors().lightPurple, .clear, Colors().lightPurple],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .padding(.horizontal, 30)
            .padding(.bottom, 15)
    }
}
