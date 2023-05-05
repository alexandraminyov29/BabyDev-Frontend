//
//  HomePage.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 13.04.2023.
//

import SwiftUI

struct HomePage: View {
   @State var jobModels: [JobListViewModel] = []
    var body: some View {
        NavigationView {
            ZStack() {
                Image("background")
                    .resizable()
                    .opacity(1)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                Color.backgroundColor.opacity(0.7)
            ScrollView {
                LazyVStack {
                        ForEach(jobModels, id: \.id) { jobModels in
                            UIFactory.shared.makeJobCardView(from: jobModels)
                        }
                    }
                }
            }
        }.ignoresSafeArea(.all)
            .onAppear {
                NetworkManager.shared.getRequest(fromURL: URL(string: "http://localhost:8080/api/jobs/all")!) {
                    (result: Result<[JobListViewModel], Error>) in
                    switch result {
                    case .success(let jobs):
                        self.jobModels = jobs
                        debugPrint("Succes")
                    case .failure(let error):
                        debugPrint("We got a failure trying to get jobs. The error we got was: \(error.localizedDescription)")
                    }
                }
            }
    }
}
