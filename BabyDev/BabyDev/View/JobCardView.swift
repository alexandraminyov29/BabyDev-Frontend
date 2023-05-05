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
            Blur(style: .systemUltraThinMaterialDark).opacity(0.6)
            VStack(spacing: .zero) {
                HStack(spacing: 20) {
                    Image("conti")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .clipShape(Capsule())
                    
                    Text(job.title)
                        .bold()
                    
                }
                Text(job.postedDate)
                Text(job.name)
                Text(job.experienceRequired)
            }
            .padding()
        }
        .frame(width: 350, height: 200)
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10) ))

    }
}

