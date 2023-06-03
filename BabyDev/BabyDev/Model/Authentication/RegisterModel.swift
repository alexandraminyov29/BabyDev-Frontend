//
//  RegisterModel.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 06.03.2023.
//

import Foundation

class RegisterModel: Codable, Identifiable, ObservableObject {
    
    var firstName: String = UserModel().firstName
    
    var lastName: String = UserModel().lastName
    
    var email: String = UserModel().email
    
    var password: String = UserModel().password
    
    var confirmPassword: String = UserModel().password
    
    var phoneNumber: String = UserModel().phoneNumber
    
}
