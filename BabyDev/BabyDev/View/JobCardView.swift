//
//  JobCardView.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 14.04.2023.
//

import SwiftUI

struct JobCardView: View {
    
  var job: JobListViewModel
  @StateObject var vm = JobCardVM()
    
    var body: some View {
        ZStack {
            Color.purple1.opacity(0.35)
            Color.black.opacity(0.15)
            Blur(style: .systemUltraThinMaterial).opacity(0.85)
            VStack(alignment: .leading, spacing: .zero) {
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
                Text(job.name)
                    .padding(.leading, 90)
                    .padding(.top, -10)
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
//                Text(job.postedDate)
//                    .font(.footnote)
//                    .padding(.trailing, 230)
//                    .padding(.top, 20)
            }
            .padding()
        }
        .frame(width: 370, height: 200)
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10) ))
    }
}

