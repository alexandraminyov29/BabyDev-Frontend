//
//  CompanyModel.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 05.05.2023.
//

import Foundation

class CompanyModel: Codable, Identifiable, ObservableObject {
    
    var id: Int = 0
    var name: String = ""
    var webPage: String = ""
}
