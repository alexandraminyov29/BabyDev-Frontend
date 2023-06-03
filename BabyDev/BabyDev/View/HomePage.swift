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
    var jobType: String?
    var hasLocationFilterApplied: Bool?
    var hasJobTypeFilterApplied: Bool?
    @State var jobModels: [JobListViewModel] = []
    @State var searchText: String = ""
    @State private var titleText: String = ""
    @State private var isShowingSheet: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundS
                VStack {
                    HStack(alignment: .top) {
                        filterButton
                        searchBar
                    }
                    filterText != "" ? cancelFilter : nil
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
                    .frame(width: 37, height: 37)
                    .foregroundColor(.white)
                    .shadow(color: Color.black.opacity(0.8), radius: 5)
                
                
            }
        }
        .padding(.leading, 7)
        .padding(.trailing, -12)
        .padding(.top, -320)
    }
    private var filterText: String {
        if hasLocationFilterApplied ?? false {
            return filter ?? ""
        } else if hasJobTypeFilterApplied ?? false {
            return jobType ?? ""
        } else {
            return ""
        }
        
    }
    
    private var cancelFilter: some View {
        HStack(spacing: 7) {
            NavigationLink(destination: HomePage(url: Constants.allJobsURL).padding(.top, 40)) {
                HStack {
                    Image(systemName: "xmark")
                    Text(filterText)
                        .bold()
                }
                .padding(.all, 7)
                .foregroundColor(.lightPurple)
                .background(Color.white.clipShape(Capsule()))
                .overlay(
                    Capsule()
                        .stroke(Color.black, lineWidth: 1)
                )
                
                
            }
        }
        .padding(.trailing, 285)
        .padding(.top, -275)
    }

    
    @ViewBuilder
    private var backgroundS: some View {
        Image("background")
            .resizable()
            .opacity(0.6)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        Color.homePageBG
            .ignoresSafeArea(.all)
            .opacity(0.6)
    }
    
    private var title: some View {
        Text(titleText).font(.largeTitle).bold().fontWidth(.standard)
            .padding(.top, 45)
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
                NetworkManager.shared.searchRequest(keyword: searchText, fromURL: Constants.searchURL ) {(result: Result<[JobListViewModel], Error>) in
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
        .padding(.top, filterText != "" ? 65 : 35)
        .onAppear {
            NetworkManager.shared.getRequest(tab: nil, location: filter ?? nil, jobType: jobType ?? nil, fromURL: url) {
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
