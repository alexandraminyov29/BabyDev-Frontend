//
//  JobCardVM.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 14.04.2023.
//

import Foundation
import Combine
import SwiftUI

class JobCardVM: ObservableObject {
    
    @Published var job = [JobModel]()
    @Published var jobModel = JobModel()
    @Published var jobDTO = [JobListViewModel]()
    @State var response : Int?
    var error: Error?
    
    func getJobById(jobId: Int) -> JobModel {
        for job in job {
            if job.id.hashValue == jobId {
                return job
            }
        }
        return JobModel()
    }

    func getJob(job: [JobModel]) {
        NetworkManager.shared.getRequest(tab: nil, location: nil, jobType: nil, fromURL: URL(string: "http://localhost:8080/api/jobs/all")!) {
            (result: Result<[JobModel], Error>) in
            switch result {
            case .success(let jobs):
               self.job = jobs
                debugPrint("Succes")
            case .failure(let error):
                debugPrint("We got a failure trying to get jobs. The error we got was: \(error.localizedDescription)")
            }
        }
    }
    
    func applyJob(jobId: Int) {
        NetworkManager.shared.applyJob(url: Constants.applyJobURL, jobId: jobId) { rsp, er  in
            if let response = rsp {
                self.response = response
                print(response)
            }
            if let error = er {
                debugPrint(error)
            }
        }
    }
    
    func addJobToFavorites(jobId: Int, isFavorite: Bool) {
        NetworkManager.shared
            .addJobToFavoritesRequest(fromURL: URL(string: "http://localhost:8080/api/jobs/favorite")!,jobId: jobId, isfavorite: isFavorite, task: jobDTO) {  (result: Result<[JobListViewModel], Error>) in
                switch result {
                case .success:
                    debugPrint("Success")
                case .failure(let error):
                    debugPrint("We got a failure trying to post. The error we got was: \(error)")}
            }
    }
}
