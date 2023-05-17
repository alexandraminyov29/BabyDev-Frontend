//
//  JobCardVM.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 14.04.2023.
//

import Foundation

class JobCardVM: ObservableObject {
    
    @Published var job = [JobModel]()

    func getJob(job: [JobModel]) {
        NetworkManager.shared.getRequest(fromURL: URL(string: "http://localhost:8080/api/jobs/all")!) {
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
        NetworkManager.shared
            .applyJobRequest(fromURL: URL(string: "http://localhost:8080/api/jobs/apply")!,jobId: jobId, task: job) {  (result: Result<[JobModel], Error>) in
            switch result {
            case .success:
                debugPrint("Success")
            case .failure(let error):
                debugPrint("We got a failure trying to post. The error we got was: \(error)")}
    }
    }
}
