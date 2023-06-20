//
//  AdminDashboard.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 20.06.2023.
//

import SwiftUI

struct AdminDashboard: View {
    
    @State var recruitersModel: [RecruiterModel] = []
    @State private var titleText: String = ""
    @State private var redirectToLogin = false
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundS
                VStack() {
                    title
                    Spacer(minLength: .zero)
                    ScrollView() {
                        recruiterRequest
                    }
                    .frame(height: 600)
                    Spacer(minLength: .zero)
                    logoffButton
                }
            }
        }
        .navigationBarBackButtonHidden(true)
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
                .onAppear {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        titleText = "Admin dashboard"
                    }
                }
            Spacer(minLength: .zero)
        }
    }
    
    private var logoffButton: some View {
        ZStack {
            Button(action: {
                UserDefaults.standard.removeObject(forKey: "token")
                UserDefaults.standard.synchronize()
                redirectToLogin = true
            }) {
                HStack {
                    Text("Logout")
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                }
                .foregroundColor(Color.red)
                .padding(.bottom, 30)

            }
            NavigationLink(destination: Login() .toolbar(.hidden, for: .tabBar), isActive: $redirectToLogin) {
                EmptyView()
            }
        }
    }
    
    private var recruiterRequest: some View {
        VStack {
            ForEach(recruitersModel, id: \.id) { recruiter in
                UIFactory.shared.makeRecruiterRequest(from: recruiter, action: getR)
            }
        }
        .onAppear {
            getR()
        }
    }
    
    func getR() {
        NetworkManager.shared.getRequest(tab: nil, location: nil, jobType: nil, fromURL: Constants.recriterRequestURL) {
            (result: Result<[RecruiterModel], Error>) in
            switch result {
            case .success(let recruiters):
                self.recruitersModel = recruiters
                debugPrint("Succes")
            case .failure(let error):
                debugPrint("We got a failure trying to get jobs. The error we got was: \(error)")
            }
        }
    }
}

