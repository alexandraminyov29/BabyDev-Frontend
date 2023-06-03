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

    func login(person : LoginModel, shouldNavigate: Binding<Bool>) {
        NetworkManager
            .shared
            .loginRequest(fromURL: Constants.loginURL, task: person, responseType: TokenModel()) {  (result: Result<TokenModel, Error>) in
                switch result {
                case .success(let token):
                    DispatchQueue.main.async {
                        shouldNavigate.wrappedValue = true
                    }
                    self.token = token
                    do { let decodedToken = try decode(jwt: token.token)
                      let id =   self.extractID(fromJWTBody: decodedToken.body)
                        UserDefaults.standard.set(id, forKey: "userID")
                        UserDefaults.standard.set(token.token, forKey: "token")
                    } catch {
                        print("")
                    }
                    AuthenticationManager.shared.setLoggedIn(true)
                    AuthenticationManager.shared.setLoginTimestamp(Date.now)
                    debugPrint(AuthenticationManager.shared.isLoggedIn())
                    debugPrint("Success")
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

}
