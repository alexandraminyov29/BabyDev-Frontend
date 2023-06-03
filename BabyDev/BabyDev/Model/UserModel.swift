//
//  UserModel.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 06.03.2023.
//

import Foundation

class UserModel: Decodable, Identifiable, ObservableObject {
    
    var id: Int = 0
    
    var firstName: String = ""
    
    var lastName: String = ""
    
    var email: String = ""
    
    var password: String = ""
    
    var phoneNumber: String = ""
    
    var imageData: String? = ""
    
   // var favoriteJobs: [JobListViewModel] = []
 //   var is_active: Bool = false
    
}
