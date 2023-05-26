//
//  Constants.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 25.05.2023.
//

import Foundation

struct Constants {
    
    static let allJobsURL = URL(string: "http://localhost:8080/api/jobs/all")!
    
    static let filteredByCityURL = URL(string: "http://localhost:8080/api/jobs/location")!
    
    static let filteredByTypeURL = URL(string: "http://localhost:8080/api/jobs/jobType")!
    
}
