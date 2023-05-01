//
//  JobModel.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 27.03.2023.
//

import Foundation
import SwiftUI

class JobModel: Codable, Identifiable, ObservableObject {
    
    var id: Int = 0
    var title: String = ""
    var postedDate: Date = Date()
    var experienceRequired: String = ""
    var companyName: String = ""
    var isPromoted: Bool = false
    
}