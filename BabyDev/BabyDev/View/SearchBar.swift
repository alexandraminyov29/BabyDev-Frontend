//
//  SearchBar.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 08.05.2023.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(.leading, 20)
            Image(systemName: "magnifyingglass")
                .padding(.trailing, 15)
//                .onTapGesture {
//                    NetworkManager.shared.getRequest(fromURL: URL(string: "http://localhost:8080/api/jobs/search")!) {(result: Result<[JobListViewModel], Error>) in
//                        switch result {
//                        case .success(let jobs):
//                           // self.jobModels = jobs
//                            debugPrint("Succes")
//                        case .failure(let error):
//                            debugPrint("We got a failure trying to get jobs. The error we got was: \(error.localizedDescription)")
//                        }
//                        
//                    }
//                }
        }
        .frame(height: 40)
        .background(Color.white.opacity(0.6))
        .cornerRadius(10)
        .padding(.horizontal, 16)
    }
}

