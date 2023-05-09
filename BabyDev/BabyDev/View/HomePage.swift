//
//  HomePage.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 13.04.2023.
//

import SwiftUI

struct HomePage: View {
    @State var jobModels: [JobListViewModel] = []
    @State var text: String = ""
    
    var body: some View {
        
        NavigationView {
            ZStack() {
                backgroundS
                searchBar
                VStack() {
                    Text("BabyDev").font(.largeTitle).bold().fontWidth(.standard)
                        .padding(.top, 60)
                        .padding(.leading, -200)
                    jobs
                        .padding(.top, 47)
                }
            }
        }
        .padding(.top, -160)
        .ignoresSafeArea(.all)
        
        
    }
    @ViewBuilder
    private var backgroundS: some View {
        
        Image("background")
            .resizable()
            .opacity(0.6)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        Color.homePageBG
            .ignoresSafeArea(.all)
        
        //  Color.backgroundColor.opacity(0.7)
        
        
    }
    
    private var searchBar: some View {
        UIFactory.shared.makeSearchBarView(from: $text)
            .padding(.top, -320)
            .onChange(of: text) { newValue in
                NetworkManager.shared.searchRequest(keyword: text, fromURL: URL(string: "http://localhost:8080/api/jobs/search")! ) {(result: Result<[JobListViewModel], Error>) in
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
    
    
    @ViewBuilder
    private var jobs: some View {
        ScrollView {
            LazyVStack {
                ForEach(self.jobModels, id: \.id) { jobModels in
                    UIFactory.shared.makeJobCardView(from: jobModels)
                }
            }
        }
        .onAppear {
            NetworkManager.shared.getRequest(fromURL: URL(string: "http://localhost:8080/api/jobs/all")!) {
                (result: Result<[JobListViewModel], Error>) in
                switch result {
                case .success(let jobs):
                    self.jobModels = jobs
                    debugPrint("Succes")
                case .failure(let error):
                    debugPrint("We got a failure trying to get jobs. The error we got was: \(error)")
                }
            }
        }
    }
}
