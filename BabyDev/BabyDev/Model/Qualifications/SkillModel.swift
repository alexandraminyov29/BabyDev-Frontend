//
//  SkillModel.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 28.05.2023.
//

import Foundation

class SkillModel: Codable, Identifiable, ObservableObject {
    
    var id: Int = 0
    
    var skillName: String = ""
    
    var skillExperience: String = ""
    
}
