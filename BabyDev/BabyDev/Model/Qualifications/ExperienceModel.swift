//
//  ExperienceModel.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 28.05.2023.
//

import Foundation

class ExperienceModel: Codable, Identifiable, ObservableObject {
    
    var id: Int = 0
    
    var title: String = ""
    
    var companyName: String = ""
    
    var position: String = ""
    
    var dateFrom: String = ""
    
    var dateTo: String = ""
    
}
