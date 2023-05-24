//
//  HomePage.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 13.04.2023.
//

import SwiftUI

struct HomePage: View {
    
    var url: URL
    var filter: String?
    @State var jobModels: [JobListViewModel] = []
    @State var searchText: String = ""
    @State private var titleText: String = ""
    @State private var isShowingSheet: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack() {
                backgroundS
                HStack(alignment: .top) {
                    filterButton
                    searchBar
                }
                VStack() {
                    title
                    jobs
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .padding(.top, -50)
        .ignoresSafeArea(.all)
    }
    
    private var filterButton: some View {
        HStack(spacing: 7) {
            NavigationLink(destination: Filters()) {
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white)
                    .shadow(color: Color.black.opacity(0.8), radius: 10)
                
                
            }
        }
        .padding(.leading, 7)
        .padding(.trailing, -12)
        .padding(.top, -320)
    }

    
    @ViewBuilder
    private var backgroundS: some View {
        Image("background")
            .resizable()
            .opacity(0.8)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        Color.homePageBG
            .ignoresSafeArea(.all)
    }
    
    private var title: some View {
        Text(titleText).font(.largeTitle).bold().fontWidth(.standard)
            .padding(.top, 50)
            .padding(.leading, -200)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.5)) {
                    titleText = "BabyDev"
                }
            }
    }
    
    private var searchBar: some View {
        UIFactory.shared.makeSearchBarView(from: $searchText)
            .padding(.top, -320)
            .onChange(of: searchText) { newValue in
                NetworkManager.shared.searchRequest(keyword: searchText, fromURL: URL(string: "http://localhost:8080/api/jobs/search")! ) {(result: Result<[JobListViewModel], Error>) in
                    switch result {
                    case .success(let jobs):
                        self.jobModels = jobs
                        debugPrint("Succes")
                    case .failure(let error):
                        debugPrint("We got a failure trying to get jobs. The error we got was: \(error.self)")
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
                        .shadow(color: Color.black.opacity(0.7), radius: 10)
                        .onTapGesture {
                            isShowingSheet = true
                        }
                }
                .sheet(isPresented: $isShowingSheet) {
                    JobDetails()
                }
                .padding(.top, 10)
            }
        }
        .padding(.top, 30)
        .onAppear {
            NetworkManager.shared.getRequest(location: filter ?? nil,fromURL: url) {
                (result: Result<[JobListViewModel], Error>) in
                switch result {
                case .success(let jobs):
                    self.jobModels = jobs
                    for job in jobs {
                        debugPrint(job.favorite)
                    }
                    debugPrint("Succes")
                case .failure(let error):
                    debugPrint("We got a failure trying to get jobs. The error we got was: \(error)")
                }
            }
        }
    }
}
