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
    @State var jobDetails: JobModel = JobModel()
    @State private var isShowDropdown = false
    @State private var showAboutSheet = false
    @State var jobId: Int = 0
    @State var response : Int?
    @State private var appliedJobAlert: Bool = false

    
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
                    UIFactory.shared.makeJobCardView(from: jobModels, showButton: false, showButtonRecruiter: false)
                        .shadow(color: Color.black.opacity(0.7), radius: 10)
                        .onTapGesture {
                            showAboutSheet = true
                            jobId = jobModels.id
                        }
                }
                .sheet(isPresented: $showAboutSheet) {
                    aboutJob
                        .onAppear {
                            NetworkManager.shared.getJobDetailsRequest(id: jobId, fromURL: Constants.jobDetails) { (result: Result<JobModel, Error>) in
                                switch result {
                                case .success(let job):
                                    jobDetails = job
                                case .failure(let failure):
                                    debugPrint(failure.self)
                                }
                            }
                        }
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
    
    @ViewBuilder
    private var aboutJob: some View {
        ZStack {
            Color.homePageBG
                .ignoresSafeArea(.all)
                .opacity(0.2)
            VStack() {
                VStack(alignment: .center, spacing: 20) {
                    Image("conti")
                        .resizable()
                        .frame(width: 120, height: 120, alignment: .center)
                        .clipShape(Capsule())
                        .padding(.top, 20)
                    
                    VStack(alignment: .center, spacing: .zero) {
                        Text(jobDetails.title)
                            .font(.system(.title, design: .default))
                            .multilineTextAlignment(.center)
                            .fontWeight(.semibold)
                    }
                }
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading, spacing: .zero) {
                        HStack() {
                            Image(systemName: "person.crop.circle.badge.clock")
                                .resizable()
                                .frame(width: 24, height: 20)
                                .padding(.leading, 2)
                            Text(" Experience required: " + jobDetails.experienceRequired)
                                .font(.title3)
                        }
                        .padding(.top, 6)
                        .padding(.leading, -145)
                        HStack() {
                            Image(systemName: "briefcase.fill")
                                .resizable()
                                .frame(width: 22, height: 20)
                                .padding(.leading, 4)
                            Text("Job Type: " + jobDetails.type.replacing("_", with: " "))
                                .font(.title3)
                                .padding(.leading, 2)
                        }
                        .padding(.top, 6)
                        .padding(.leading, -145)
                        HStack() {
                            Image(systemName: "mappin.and.ellipse")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .padding(.leading, 4)
                            Text(" Location: " + jobDetails.location)
                                .padding(.leading, 2)
                                .font(.title3)
                        }
                        .padding(.top, 6)
                        .padding(.leading, -145)
                            HStack() {
                                Image(systemName: "calendar")
                                    .resizable()
                                    .frame(width: 24, height: 20)
                                    .padding(.leading, 2)
                                Text(" Date of post: " + jobDetails.postedDate)
                                    .font(.title3)
                            }
                            .padding(.top, 6)
                            .padding(.leading, -145)

                    }
                    .frame(width: 450, height: 180)
                    .background(Color.white.clipShape(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5))))
                    .shadow(color: .lightPurple.opacity(0.4), radius: 15)
                    .padding(.top, 30)
                        VStack(alignment: .leading) {
                            Text("Job description")
                                .fontWeight(.semibold)
                                .font(.title2)
                                .padding(.leading, 5)
                                .padding(.bottom, 20)
                            SeparatorView()
                                .padding(.horizontal, -66)
                                .padding(.leading, 29)
                                .padding(.top, -10)
                            ScrollView {
                                VStack(alignment: .leading) {
                                    Text("   \(jobDetails.description)")
                                        .padding(.leading, 5)
                                        .font(.title3)
                                        .multilineTextAlignment(.leading)
                                }
                            }
                            .frame(width: 400, height: 200)
                        }
                    .padding(.all, 20)
                    .frame(width: 410)
                    .background(Color.white.clipShape(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5))))
                    .shadow(color: .lightPurple.opacity(0.4), radius: 15)
                    .padding(.leading, 20)
                    .padding(.top, 5)
                }
                Spacer(minLength: .zero)
                UIFactory.shared.makeApplyJobFromDetailsButton {
                    NetworkManager.shared.applyJob(url: Constants.applyJobURL, jobId: jobId) { rsp, er  in
                        if let response = rsp {
                            self.response = response
                            if response == 409 {
                                self.appliedJobAlert = true
                            }
                        }
                        if let error = er {
                            debugPrint(error)
                        }
                    }
                }
                .padding(.bottom, 10)
                .alert(isPresented: $appliedJobAlert) {
                    Alert(
                        title: Text("OOPS..."),
                        message: Text("You already applied to this job.").font(.title3),
                        dismissButton: .default(Text("OK"))
                        )
                }
            }
        }
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

