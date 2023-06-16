//
//  Constants.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 25.05.2023.
//

import Foundation

struct Constants {
    
    static let allJobsURL = URL(string: "http://localhost:8080/api/jobs/all")!
    
    static let recommendedJobsURL = URL(string: "http://localhost:8080/api/jobs/recommend")!
    
    static let favoriteJobsURL = URL(string: "http://localhost:8080/api/jobs/favorites")!
    
    static let appliedJobsURL = URL(string: "http://localhost:8080/api/jobs/applied")!
    
    static let jobDetails = URL(string: "http://localhost:8080/api/jobs/jobDetails")!
    
    static let filteredByCityURL = URL(string: "http://localhost:8080/api/jobs/location")!
    
    static let filteredByTypeURL = URL(string: "http://localhost:8080/api/jobs/jobType")!
    
    static let searchURL = URL(string: "http://localhost:8080/api/jobs/search")!
    
    static let registerURL = URL(string: "http://localhost:8080/api/auth/register")!
    
    static let loginURL =  URL(string: "http://localhost:8080/api/auth/authenticate")!
    
    static let userProfileURL = URL(string: "http://localhost:8080/api/users/myprofile")!
    
    static let educationURL = URL(string: "http://localhost:8080/api/qualifications/education")!
    
    static let experienceURL = URL(string: "http://localhost:8080/api/qualifications/experience")!
    
    static let skillURL = URL(string: "http://localhost:8080/api/qualifications/skill")!
    
    static let editPhoneNumber = URL(string: "http://localhost:8080/api/users/phoneno")!
    
    static let addUserPhoto = URL(string: "http://localhost:8080/api/users/image")!

}
