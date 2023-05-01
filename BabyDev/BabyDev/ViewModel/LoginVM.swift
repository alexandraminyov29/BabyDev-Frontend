//
//  LoginVM.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 25.03.2023.
//

import Foundation
import SwiftUI

class LoginVM: ObservableObject {
    @Published var person = LoginModel()

    func login(person : LoginModel, shouldNavigate: Binding<Bool>) {
        NetworkManager
            .shared
            .postRequest(fromURL: URL(string: "http://localhost:8080/api/auth/authenticate")!, task: person) {  (result: Result<LoginModel, Error>) in
                switch result {
                case .success:
                    DispatchQueue.main.async {
                        shouldNavigate.wrappedValue = true
                    }
                    AuthenticationManager.shared.setLoggedIn(true)
                    AuthenticationManager.shared.setLoginTimestamp(Date.now)
                    debugPrint(AuthenticationManager.shared.isLoggedIn())
                    debugPrint("Success")
                case .failure:
                    debugPrint("We got a failure trying to post. The error we got was")}
            }
    }
}
