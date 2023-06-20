//
//  JobDetails.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 24.05.2023.
//

import SwiftUI

struct JobDetails: View {
    
    @State var jobModel: JobModel = JobModel()
    @State var jobId: Int
    @StateObject var vm = JobCardVM()

    var body: some View {
        ZStack {
            Color.homePageBG
                .ignoresSafeArea(.all)
                .opacity(0.6)
            VStack {
                HStack(spacing: 20) {
                    Image("conti")
                        .resizable()
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
                
                Text(jobModel.name)
                    .padding(.leading, 90)
                    .padding(.top, -10)
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
                    HStack() {
                        Image(systemName: "mappin.and.ellipse")
                            .padding(.leading, 2)
                        Text(" Description: " + jobModel.description)
                            .padding(.leading, 2)
                    }
                }
                
            }
        }
    }
    
    private var backgroundS: some View {
        Color.homePageBG
            .ignoresSafeArea(.all)
            .opacity(0.6)
    }
    
    @ViewBuilder
    private var jobHeader: some View {
        HStack(spacing: 20) {
            Image("conti")
                .resizable()
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
    
    private var applyButton: some View {
        UIFactory.shared.makeApplyButton {
            vm.applyJob(jobId: jobModel.id)
        }
        .padding(.top, 140)
        .padding(.leading, 250)
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
            HStack() {
                Image(systemName: "mappin.and.ellipse")
                    .padding(.leading, 2)
                Text(" Description: " + jobModel.description)
                    .padding(.leading, 2)
            }
        }
    }

    @ViewBuilder
    private var informations: some View {
        VStack {
            jobHeader
            companyName
            jobDetails
        }
    }
}

