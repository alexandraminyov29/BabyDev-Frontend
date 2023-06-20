//
//  ApplicantsListView.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 20.06.2023.
//

import SwiftUI

struct ApplicantsListView: View {
    
    @State var applicantsModel: [ApplicantModel] = []
    @State private var titleText: String = ""
    var jobId: Int

    var body: some View {
        ZStack {
            backgroundS
            VStack(alignment: .leading) {
                title
                Spacer(minLength: .zero)
                ScrollView {
                    applicantsList
                }
                .frame(height: 600)
                Spacer(minLength: .zero)
            }
        }
    }
    
    private var backgroundS: some View {
        Color.homePageBG
            .ignoresSafeArea(.all)
            .opacity(0.6)
    }
    
    private var title: some View {
        HStack(alignment: .top) {
            Text(titleText).font(.largeTitle).bold().fontWidth(.standard)
                .padding(.leading, 20)
                .padding(.top, 20)
                .onAppear {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        titleText = "Applicants"
                    }
                }
            Spacer(minLength: .zero)
        }
    }
    
    private var applicantsList: some View {
        VStack(alignment: .leading) {
            ForEach(applicantsModel, id: \.id) { applicant in
                VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "person")
                        .resizable()
                        .foregroundColor(Color.lightPurple)
                        .frame(width: 21, height: 19)
                        .padding(.leading, 35)
                    Text("   ")
                    Text(applicant.firstName)
                        .fontWeight(.semibold)
                        .padding(.leading, -15)
                    Text(applicant.lastName)
                        .fontWeight(.semibold)
                }
                HStack(spacing: .zero) {
                    Image(systemName: "envelope")
                        .resizable()
                        .foregroundColor(Color.lightPurple)
                        .frame(width: 23, height: 19)
                        .padding(.leading, 35)
                    Text("   ")
                    Text(applicant.email)
                }
                .foregroundColor(.black)
                    SeparatorView()
            }
        }
        }
        .onAppear {
            getApplicants()
        }
    }
    
    func getApplicants() {
        NetworkManager.shared.getApplicantsRequest(jobId: jobId, fromURL: Constants.applicantsRequestURL) { (result: Result<[ApplicantModel], Error>) in
            switch result {
            case .success(let applicants):
                self.applicantsModel = applicants
            case .failure(let error):
                debugPrint(error.self)
            }
        }
    }
}

