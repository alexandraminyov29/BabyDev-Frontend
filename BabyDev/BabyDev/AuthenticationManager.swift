//
//  AuthenticationManager.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 11.04.2023.
//

import Foundation

final class AuthenticationManager: ObservableObject {
    
    static let shared = AuthenticationManager()
    
    private init() {}
    
    private let isLoggedInKey = "isLoggedIn"
    private let user = "userId"
    
    func isLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: isLoggedInKey)
    }
    
    func setLoggedIn(_ isLoggedIn: Bool) {
        UserDefaults.standard.set(isLoggedIn, forKey: isLoggedInKey)
    }
}
