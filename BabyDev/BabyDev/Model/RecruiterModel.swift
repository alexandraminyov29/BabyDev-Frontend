//
//  RecruiterModel.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 20.06.2023.
//

import Foundation

class RecruiterModel: Codable, Identifiable, ObservableObject {
        
    var firstName: String = ""
    
    var lastName: String = ""
    
    var email: String = ""
    
    var companyName: String = ""
    
}
