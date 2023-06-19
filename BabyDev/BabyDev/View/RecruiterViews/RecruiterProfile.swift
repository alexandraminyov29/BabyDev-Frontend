//
//  RecruiterProfile.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 19.06.2023.
//

import SwiftUI

struct RecruiterProfile: View {
    
    @State private var titleText: String = ""
    @State var userModel: [PersonalDetailsModel] = []
    @State private var redirectToLogin = false
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundS
                VStack {
                    userImage
                    userName
                    Spacer(minLength: .zero)
                    userPersonalDetails
                    Spacer(minLength: .zero)
                    logoffButton
                    Spacer(minLength: .zero)
                }
            }
        }
    }
    
    private var backgroundS: some View {
        Color.profilePageBG
            .ignoresSafeArea(.all)
            .opacity(0.6)
    }
    
    private var userImage: some View {
        VStack {
            if let image = base64ToImage(base64String: userModel.first?.imageData ?? "")
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
    
    private var userName: some View {
        HStack(spacing: .zero) {
            Text(userModel.first?.firstName ?? "")
            Text(" ")
            Text(userModel.first?.lastName ?? "")
        }
        .font(.title)
        .fontWeight(.semibold)
        .padding(.top, 5)
        .foregroundColor(.black)
        .shadow(color: .gray, radius: 10)
        .onAppear {
            getUserDetails()
        }
    }
    
    private var userPersonalDetails: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Personal Details")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding(.bottom, 15)
                    .padding(.leading, 200)
            }
            SeparatorView()
                .frame(width: 400)
                .padding(.top, -14)
            HStack(spacing: .zero) {
                Image(systemName: "envelope")
                    .resizable()
                    .foregroundColor(Color.lightPurple)
                    .frame(width: 23, height: 19)
                    .padding(.leading, 25)
                Text("   ")
                Text(userModel.first?.email ?? "")
            }
            .foregroundColor(.black)
            
            HStack(spacing: .zero) {
                Image(systemName: "phone")
                    .resizable()
                    .foregroundColor(Color.lightPurple)
                    .frame(width: 23, height: 23)
                    .padding(.leading, 25)
                Text("   ")
                Text(userModel.first?.phoneNumber ?? "")
            }
            .font(.title3)
            .foregroundColor(.black)
            
        }
        .frame(width: 400, height: 150)
        .clipShape(RoundedRectangle(cornerRadius: 10 ,style: .circular))
        .padding(.top, 35)
        .onAppear {
            getUserDetails()
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
                .padding(.top, 30)
            }
            NavigationLink(destination: Login() .toolbar(.hidden, for: .tabBar), isActive: $redirectToLogin) {
                EmptyView()
            }
        }
    }
    
    private func getUserDetails() {
        NetworkManager.shared.getProfileRequest(tab: "1", email: nil, fromURL: Constants.userProfileURL) { (result: Result<PersonalDetailsModel, Error>) in
            switch result {
            case .success(let user):
                self.userModel = [user]
                debugPrint("Succes")
            case .failure(let error):
                debugPrint("Error \(error.localizedDescription)")
                
            }
        }
    }
}
