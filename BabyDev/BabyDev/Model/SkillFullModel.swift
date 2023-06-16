//
//  SkillFullModel.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 06.06.2023.
//

import Foundation

class SkillFullModel: Codable, Identifiable, ObservableObject {
     
    var skills: [SkillModel] = [SkillModel()]
    
    var skillNames: [String] = []
}
