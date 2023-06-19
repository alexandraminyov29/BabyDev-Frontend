//
//  Favorites.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 24.05.2023.
//

import SwiftUI

struct FavoriteJobs: View {
    
    @State private var titleText: String = ""
    @State var jobModels: [JobListViewModel] = []
    @State private var showDropdown = false

    var body: some View {
        NavigationView {
            ZStack {
                backgroundS
                VStack {
                    HStack {
                        title
                        buttonSelectView
                    }
                    jobs
                }
                .blur(radius: showDropdown ? 3 : 0)
                selectViewDropdown
            }
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.all)
    }
    
    @ViewBuilder
    private var backgroundS: some View {
        Image("background")
            .resizable()
            .padding(.top, -50)
            .opacity(0.6)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        Color.homePageBG
            .ignoresSafeArea(.all)
            .opacity(0.6)
    }
    
    private var buttonSelectView: some View {
        Button(action: {
            showDropdown.toggle()
        }) {
            Image(systemName: "chevron.down")
                .resizable()
                .frame(width: 20, height: 12)
                .padding(.top, 5)
                .foregroundColor(.black)
        }
    }
    
    private var title: some View {
        HStack {
            Text(titleText).font(.largeTitle).bold().fontWidth(.standard)
                .padding(.leading, -175)
                .onAppear {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        titleText = "Favorite jobs"
                    }
                }
        }
    }
    
    private var selectViewDropdown: some View {
        showDropdown ? CustomizedDropdown(showDropdown: showDropdown) : nil
    }
    
    @ViewBuilder
    private var jobs: some View {
        ScrollView {
            LazyVStack {
                ForEach(self.jobModels, id: \.id) { jobModels in
                    UIFactory.shared.makeJobCardView(from: jobModels, showButton: true)
                        .shadow(color: Color.black.opacity(0.7), radius: 10)
                }
                .padding(.top, 10)
            }
        }
        .padding(.top, 15)
        .onAppear {
            NetworkManager.shared.getRequest(tab: nil, location: nil, jobType: nil, fromURL: Constants.favoriteJobsURL) {
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

