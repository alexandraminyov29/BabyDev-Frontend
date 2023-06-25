//
//  RegisterVM.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 06.03.2023.
//

import Foundation
import SwiftUI

class RegisterVM: ObservableObject {
    
    @Published var person = RegisterModel()
    
    func createAccount(person: RegisterModel, shouldNavigate: Binding<Bool>) {
        NetworkManager
            .shared
            .postRequest(fromURL: Constants.registerURL, task: person) {  (result: Result<RegisterModel, Error>) in
                switch result {
                case .success:
                    DispatchQueue.main.async {
                        shouldNavigate.wrappedValue = true
                    }
                case .failure(let error):
                    debugPrint("The error we got was: \(error)")}
        }
    }
}
