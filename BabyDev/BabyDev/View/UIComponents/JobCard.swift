//
//  JobCardView.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 14.04.2023.
//

import SwiftUI

struct Jobcard: View {
    
    var jobModel: JobListViewModel
    @State var applicantsModel: [ApplicantModel]?
    var showButton: Bool
    var showButtonRecruiter: Bool?
    @StateObject var vm = JobCardVM()
    @State var isFavorite: Bool = false
    @State var response : Int?
    @State var jobId: Int = 0
    @State private var selectedImage: Image?
    @State private var showAppliedJobAlert: Bool = false
    @State private var isShowingImagePicker: Bool = false
    @State private var showApplicants: Bool = false
    
    var body: some View {
        ZStack {
            background
            showButton ? favoriteButton : nil
            HStack() {
                VStack(alignment: .leading, spacing: .zero) {
                    VStack(alignment: .leading, spacing: .zero)  {
                        jobHeader
                        companyName
                        jobDetails
                    }
                    .padding(.top, 25)
                    jobDate
                }
                .padding()
            }
            showButton ? applyButton : nil
            showButtonRecruiter ?? false ? seeApplicantsButton : nil
        }
        .frame(width: 370, height: 200)
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10) ))
        .padding(.top, 7)
        .padding(.bottom, 5)
    }
    
    @ViewBuilder
    private var background: some View {
        Color.white.opacity(1)
        Color.lightPurple.opacity(0.25)
        Blur(style: .systemUltraThinMaterial).opacity(0.35)
    }
    
    private var jobImage: some View {
        VStack {
            if let image = base64ToImage(base64String: jobModel.image ?? "")
                ?? Image("img") {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 130, height: 130)
                    .clipShape(Capsule(style: .circular))
                    .shadow(color: .black, radius: 5)
            }
        }
        .padding(.top, 20)
    }
    
    @ViewBuilder
    private var jobHeader: some View {
        HStack(spacing: 20) {
            jobImage
                .frame(width: 70, height: 70, alignment: .leading)
                .clipShape(Capsule())
                .padding(.top, -10)
            
            VStack(alignment: .leading) {
                Text(jobModel.title)
                    .font(.system(.title, design: .default))
                    .fontWeight(.semibold)
                SeparatorView()
                    .padding(.leading, -30)
                    .padding(.top, -10)
            }
        }
    }
    
    private var companyName: some View {
        Text(jobModel.name)
            .padding(.leading, 90)
            .padding(.top, -10)
    }
    
    private var favoriteButton: some View {
        UIFactory.shared.makeFavoriteButton(isFavorite: jobModel.favorite) {
            vm.addJobToFavorites(jobId: jobModel.id, isFavorite: jobModel.favorite)
        }
        .padding(.top, -85)
        .padding(.leading, 300)
    }
    
    private var applyButton: some View {
        UIFactory.shared.makeApplyButton {
            NetworkManager.shared.applyJob(url: Constants.applyJobURL, jobId: jobModel.id) { rsp, er  in
                if let response = rsp {
                    self.response = response
                    if response == 409 {
                        self.showAppliedJobAlert = true
                    }
                    debugPrint(response)
                }
                if let error = er {
                    debugPrint(error)
                }
            }
        }
        .padding(.top, 140)
        .padding(.leading, 250)
        .alert(isPresented: $showAppliedJobAlert) {
            Alert(
                title: Text("OOPS..."),
                message: Text("You already applied to this job."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    private var seeApplicantsButton: some View {
        UIFactory.shared.makeSeeApplicantsButton {
            showApplicants = true
        }
        .padding(.top, 140)
        .padding(.leading, 210)
        .sheet(isPresented: $showApplicants) {
            ApplicantsListView(jobId: jobModel.id)
        }
    }
    
    private var jobDate: some View {
        Text(jobModel.postedDate.replacing("-", with: "."))
            .font(.footnote)
            .padding(.trailing, 230)
            .padding(.top, 25)
    }
    
    @ViewBuilder
    private var jobDetails: some View {
        VStack(alignment: .leading, spacing: .zero) {
            HStack() {
                Image(systemName: "person.crop.circle.badge.clock")
                    .padding(.leading, 2)
                Text(" Experience: " + jobModel.experienceRequired)
            }
            HStack() {
                Image(systemName: "briefcase.fill")
                Text("Job Type: " + jobModel.type.replacing("_", with: " "))
                    .padding(.leading, 2)
            }
            HStack() {
                Image(systemName: "mappin.and.ellipse")
                    .padding(.leading, 2)
                Text(" Location: " + jobModel.location)
                    .padding(.leading, 2)
            }
        }
    }
}

