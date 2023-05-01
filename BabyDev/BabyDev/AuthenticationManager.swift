//
//  AuthenticationManager.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 11.04.2023.
//

import Foundation

final class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    
    private init() {}
    
    private let isLoggedInKey = "isLoggedIn"
    private let loginTimestampKey = "loginTimestamp"
    
    func isLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: isLoggedInKey)
    }
    
    func setLoggedIn(_ isLoggedIn: Bool) {
        UserDefaults.standard.set(isLoggedIn, forKey: isLoggedInKey)
    }
    
    func setLoginTimestamp(_ timestamp: Date) {
        UserDefaults.standard.set(timestamp, forKey: loginTimestampKey)
    }
    
    func shouldAskForLogin() -> Bool {
        guard let loginTimestamp = UserDefaults.standard.object(forKey: loginTimestampKey) as? Date else { return true }
        let now = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: loginTimestamp, to: now)
        return components.day! > 30
    }
    
}
