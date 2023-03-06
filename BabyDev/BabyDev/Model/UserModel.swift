//
//  UserModel.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 06.03.2023.
//

import Foundation

class UserModel: Codable, Identifiable, ObservableObject {
    
    var id: Int = 0
    var first_name: String = ""
    var last_name: String = ""
    var email: String = ""
    var password: String = ""
    var phone_number: String = ""
    var is_active: Bool = false
    
}
