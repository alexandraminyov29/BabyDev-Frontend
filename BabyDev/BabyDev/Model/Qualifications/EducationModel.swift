//
//  EducationModel.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 28.05.2023.
//

import Foundation

class EducationModel: Codable, Identifiable, ObservableObject {
    
    var id: Int = 0
    
    var institution: String = ""
    
    var subject: String = ""
    
    var dateFrom: String = ""
    
    var dateTo: String = ""
    
    var degree: String = ""
    
}
