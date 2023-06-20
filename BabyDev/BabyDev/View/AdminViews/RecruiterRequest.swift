//
//  RecruiterRequest.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 20.06.2023.
//

import SwiftUI

struct RecruiterRequest: View {
    
    var recruiterModel: RecruiterModel
    @State private var showAcceptedAlert: Bool = false
    @State private var showDeclinedAlert: Bool = false
    var action: () -> Void


    
    var body: some View {
        recruiterDetails
        SeparatorView()
    }
    
    private var recruiterDetails: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "person")
                        .resizable()
                        .foregroundColor(Color.lightPurple)
                        .frame(width: 21, height: 19)
                        .padding(.leading, 35)
                    Text("   ")
                    Text(recruiterModel.firstName)
                        .fontWeight(.semibold)
                        .padding(.leading, -15)
                    Text(recruiterModel.lastName)
                        .fontWeight(.semibold)
                }
                HStack(spacing: .zero) {
                    Image(systemName: "envelope")
                        .resizable()
                        .foregroundColor(Color.lightPurple)
                        .frame(width: 23, height: 19)
                        .padding(.leading, 35)
                    Text("   ")
                    Text(recruiterModel.email)
                }
                .foregroundColor(.black)
                HStack(spacing: .zero) {
                    Image(systemName: "building.2")
                        .resizable()
                        .foregroundColor(Color.lightPurple)
                        .frame(width: 23, height: 19)
                        .padding(.leading, 35)
                    Text("   ")
                    Text(recruiterModel.companyName)
                }
            }
            Spacer(minLength: .zero)
            UIFactory.shared.makeAcceptButton {
                approveRequest()
                showAcceptedAlert = true
            }
            .padding(.trailing, 20)
            UIFactory.shared.makeDeclineButton {
                declineRequest()
                showDeclinedAlert = true
            }
            .padding(.trailing, 35)
        }
        .alert(isPresented: showAcceptedAlert ? $showAcceptedAlert : $showDeclinedAlert) {
            Alert(title: showAcceptedAlert ? Text("Request accepted!") : Text("Request declined!"),
                  dismissButton: .default(Text("OK"), action: action))
        }
    }
    
    func approveRequest() {
        NetworkManager.shared.acceptRequestRecruiterRequest(fromURL: Constants.acceptRecriterRequestURL, email: recruiterModel.email, task: recruiterModel) { (result: Result<RecruiterModel, Error>) in
            switch result {
            case .success:
                debugPrint("YEY")
            case .failure(let error):
                debugPrint(error.self)
            }
        }
    }
    
    func declineRequest() {
        NetworkManager.shared.declineRecruiterRequestRequest(fromURL: Constants.declineRecriterRequestURL, email: recruiterModel.email) { (result: Result<RecruiterModel, Error>) in
            switch result {
            case .success:
                debugPrint("YEY")
            case .failure(let error):
                debugPrint(error.self)
            }
        }
    }
}

