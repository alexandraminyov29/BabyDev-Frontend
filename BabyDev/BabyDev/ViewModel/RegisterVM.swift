//
//  RegisterVM.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 06.03.2023.
//

import Foundation

class RegisterVM: ObservableObject {
    
    @Published var person = RegisterModel()
    
    func createAccount(person: RegisterModel) {
        NetworkManager
            .shared
            .postRequest(fromURL: URL(string: "http://localhost:8080/api/auth/register")!, task: person) {  (result: Result<RegisterModel, Error>) in
                switch result {
                case .success:
                    debugPrint("Success")
                case .failure(let error):
                    debugPrint("We got a failure trying to post. The error we got was: \(error)")}
            }
    }
}
