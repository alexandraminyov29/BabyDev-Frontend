//
//  RegisterModel.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 06.03.2023.
//

import Foundation

class RegisterModel: Codable, Identifiable, ObservableObject {
    
    var first_name: String = UserModel().first_name
    var last_name: String = UserModel().last_name
    var email: String = UserModel().email
    var password: String = UserModel().password
    var confirmPassword: String = UserModel().password
    var phone_number: String = UserModel().phone_number
    
}
