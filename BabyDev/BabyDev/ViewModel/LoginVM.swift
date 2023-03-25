//
//  LoginVM.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 25.03.2023.
//

import Foundation

class LoginVM: ObservableObject {
    @Published var person = LoginModel()

    func login(person : LoginModel) {
        NetworkManager
            .shared
            .postRequest(fromURL: URL(string: "http://localhost:8080/api/auth/authenticate")!, task: person) {  (result: Result<LoginModel, Error>) in
                switch result {
                case .success:
                    debugPrint("Success")
                case .failure(let error):
                    debugPrint("We got a failure trying to post. The error we got was: \(error)")}
            }
    }
}
