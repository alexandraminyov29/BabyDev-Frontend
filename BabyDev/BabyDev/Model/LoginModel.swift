//
//  LoginModel.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 25.03.2023.
//

import Foundation

class LoginModel: Codable, Identifiable, ObservableObject {
    
    var email: String = UserModel().email
    var password: String = UserModel().password
}
