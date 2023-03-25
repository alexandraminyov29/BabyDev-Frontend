//
//  Blur.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 25.03.2023.
//

import SwiftUI

struct Blur: UIViewRepresentable {
    
    var style: UIBlurEffect.Style = .systemMaterial
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
