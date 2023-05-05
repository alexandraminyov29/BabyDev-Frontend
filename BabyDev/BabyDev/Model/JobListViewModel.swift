//
//  JobListView.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 05.05.2023.
//

import Foundation
import SwiftUI

class JobListViewModel: Codable, Identifiable, ObservableObject {
    
    var title: String = JobModel().title
    var postedDate: String = ""
    var name: String = JobModel().name
    var experienceRequired: String = JobModel().experienceRequired
    
}
