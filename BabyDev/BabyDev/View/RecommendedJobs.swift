//
//  RecommendedJobs.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 06.06.2023.
//

import SwiftUI

struct RecommendedJobs: View {
    
    @State private var titleText: String = ""
    @State var jobModels: [JobListViewModel] = []
    @State private var isShowDropdown = false

    
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
                .blur(radius: isShowDropdown ? 3 : 0)
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
            isShowDropdown.toggle()
        }) {
            Image(systemName: "chevron.down")
                .resizable()
                .frame(width: 20, height: 12)
                .padding(.top, 5)
                .foregroundColor(.black)
        }
    }
    
    private var title: some View {
        Text(titleText).font(.largeTitle).bold().fontWidth(.standard)
            .padding(.leading, -165)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.5)) {
                    titleText = "Suggestions"
                }
            }
    }
    
    private var selectViewDropdown: some View {
        isShowDropdown ? CustomizedDropdown(showDropdown: isShowDropdown) : nil
    }
    
    @ViewBuilder
    private var jobs: some View {
        ScrollView {
            LazyVStack {
                ForEach(self.jobModels, id: \.id) { jobModels in
                    UIFactory.shared.makeJobCardView(from: jobModels)
                        .shadow(color: Color.black.opacity(0.7), radius: 10)
                }
                .padding(.top, 10)
            }
            .onAppear {
                if let fetchedData = UserDefaults.standard.data(forKey: "fetchedData") {
                    decodeSavedData(fetchedData)
                } else {
                    NetworkManager.shared.getRecommendedJobsRequest(tab: nil, location: nil, jobType: nil, fromURL: Constants.recommendedJobsURL) {
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
        .padding(.top, 15)
        
    }
    
    private func decodeSavedData(_ savedData: Data) {
           do {
               let decoder = JSONDecoder()
               let result = try decoder.decode([JobListViewModel].self, from: savedData)
               self.jobModels = result
           } catch {
               print("Error decoding saved data: \(error)")
           }
       }
}

