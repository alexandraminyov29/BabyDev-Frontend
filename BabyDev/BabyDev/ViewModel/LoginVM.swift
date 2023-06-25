//
//  LoginVM.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 25.03.2023.
//

import Foundation
import SwiftUI
import JWTDecode

class LoginVM: ObservableObject {
    @Published var person = LoginModel()
    @State var token = TokenModel()

    func login(person : LoginModel, shouldNavigate: Binding<Bool>, shouldNavigateRecruiter: Binding<Bool>, shouldNavigateAdmin: Binding<Bool>) {
        NetworkManager
            .shared
            .loginRequest(fromURL: Constants.loginURL, task: person, responseType: TokenModel()) {  (result: Result<TokenModel, Error>) in
                switch result {
                case .success(let token):
                    self.token = token
                    do {
                        let decodedToken = try decode(jwt: token.token)
                         let id =   self.extractID(fromJWTBody: decodedToken.body)
                         let role = self.extractRole(fromJWTBody: decodedToken.body)
                         UserDefaults.standard.set(id, forKey: "userID")
                         UserDefaults.standard.set(token.token, forKey: "token")
                        DispatchQueue.main.async {
                            if role == "STANDARD" {
                                UserDefaults.standard.set("STANDARD", forKey: "role")
                                shouldNavigate.wrappedValue = true
                                shouldNavigateRecruiter.wrappedValue = false
                                shouldNavigateAdmin.wrappedValue = false
                            } else if role == "RECRUITER" {
                                UserDefaults.standard.set("RECRUITER", forKey: "role")
                                shouldNavigate.wrappedValue = false
                                shouldNavigateRecruiter.wrappedValue = true
                                shouldNavigateAdmin.wrappedValue = false
                            } else if role == "ADMIN" {
                                UserDefaults.standard.set("ADMIN", forKey: "role")
                                shouldNavigate.wrappedValue = false
                                shouldNavigateRecruiter.wrappedValue = false
                                shouldNavigateAdmin.wrappedValue = true
                            }
                        }
                        
                    } catch {
                        print("")
                    }
                case .failure(let error):
                    debugPrint("We got a failure trying to post. The error we got was \(error)")}
            }
    }
    
    func extractID(fromJWTBody body: [String: Any]) -> Int? {
        for (key, value) in body {
            if key == "id", let id = value as? Int {
                return id
            }
        }
        return nil
    }
    
    func extractRole(fromJWTBody body: [String: Any]) -> String? {
        for (key, value) in body {
            if key == "role", let role = value as? String {
                return role
            }
        }
        return nil
    }
}
