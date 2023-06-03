//
//  PersonalDetailsModel.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 27.05.2023.
//

import Foundation

class PersonalDetailsModel: Codable, Identifiable, ObservableObject {
    
    var firstName: String = UserModel().firstName
    
    var lastName: String = UserModel().lastName
    
    var email: String = UserModel().email
    
    var phoneNumber: String = UserModel().phoneNumber
    
    var imageData: String? = UserModel().imageData
    
}
