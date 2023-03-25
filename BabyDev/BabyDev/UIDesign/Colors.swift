//
//  Color.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 13.03.2023.
//

import Foundation
import SwiftUI

struct Colors {
    
    let purple: Color = Color(red: 0.35, green: 0.13, blue: 0.87)
    let lightPurple: Color = Color(red: 0.64, green: 0.52, blue: 0.93)
    let backgroundColor = LinearGradient(gradient: Gradient(colors: [Color(red: 0.35, green: 0.13, blue: 0.87), .white ,.white]), startPoint: .topLeading, endPoint: .bottom)
    let bg = LinearGradient(gradient: Gradient(colors: [.white, .white, Color(red: 0.35, green: 0.13, blue: 0.87)]), startPoint: .topLeading , endPoint: .bottom)

    
}
