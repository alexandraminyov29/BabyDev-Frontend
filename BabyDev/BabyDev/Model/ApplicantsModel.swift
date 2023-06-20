//
//  ApplicantModel.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 20.06.2023.
//

import Foundation

class ApplicantModel: Decodable, Identifiable, ObservableObject {
    
    var id: Int = 0
    
    var firstName: String = ""
    
    var lastName: String = ""
    
    var email: String = ""
    
    var imageData: String? = ""
    
}
