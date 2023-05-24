//
//  JobCardView.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 14.04.2023.
//

import SwiftUI

struct Jobcard: View {
    
    var job: JobListViewModel
    
    @StateObject var vm = JobCardVM()
    @State var isFavorite: Bool = false
    
    var body: some View {
        ZStack {
            background
            favoriteButton
            HStack() {
                VStack(alignment: .leading, spacing: .zero) {
                    jobHeader
                    companyName
                    jobDetails
                }
                .padding()
            }
            applyButton
        }
        .frame(width: 370, height: 200)
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10) ))
        .padding(.top, 7)
        .padding(.bottom, 5)
    }
    
    @ViewBuilder
    private var background: some View {
        Color.bej.opacity(1)
        Blur(style: .systemUltraThinMaterial).opacity(0.85)
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
                Text(job.title)
                    .font(.system(.title, design: .default))
                    .fontWeight(.semibold)
                SeparatorView()
                    .padding(.leading, -30)
                    .padding(.top, -10)
            }
        }
    }
    
    private var companyName: some View {
        Text(job.name)
            .padding(.leading, 90)
            .padding(.top, -10)
    }
    
    private var favoriteButton: some View {
        UIFactory.shared.makeFavoriteButton(isFavorite: job.favorite) {
            vm.addJobToFavorites(jobId: job.id, isFavorite: job.favorite)
        }
        .padding(.top, -85)
        .padding(.leading, 300)
    }
    
    private var applyButton: some View {
        UIFactory.shared.makeApplyButton {
            vm.applyJob(jobId: job.id)
        }
        .padding(.top, 140)
        .padding(.leading, 250)
    }
    //    private var jobDate: some View {
    //        Text(job.postedDate)
    //            .font(.footnote)
    //            .padding(.trailing, 230)
    //            .padding(.top, 20)
    //    }
    
    @ViewBuilder
    private var jobDetails: some View {
        VStack(alignment: .leading, spacing: .zero) {
            HStack() {
                Image(systemName: "person.crop.circle.badge.clock")
                    .padding(.leading, 2)
                Text(" Experience: " + job.experienceRequired)
            }
            HStack() {
                Image(systemName: "briefcase.fill")
                Text("Job Type: " + job.type)
                    .padding(.leading, 2)
            }
            HStack() {
                Image(systemName: "mappin.and.ellipse")
                    .padding(.leading, 2)
                Text(" Location: " + job.location)
                    .padding(.leading, 2)
            }
        }
    }
}

