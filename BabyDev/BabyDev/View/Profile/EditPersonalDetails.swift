//
//  EditPersonalDetails.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 29.05.2023.
//

import SwiftUI

struct EditPersonalDetails: View {
    
    @State var userModel: PersonalDetailsModel = PersonalDetailsModel()
    @State private var titleText: String = ""
    @Binding var isSheetPresented: Bool
    
    var body: some View {
        ZStack {
            backgroundS
            VStack {
                title
                Spacer(minLength: .zero)
                VStack(alignment: .center) {
                    userDetails
                    saveButton
                    image
                }
                Spacer(minLength: .zero)
            }
        }
    }
    
    private var backgroundS: some View {
        Color.homePageBG
            .ignoresSafeArea(.all)
            .opacity(0.6)
    }
    
    private var title: some View {
        Text(titleText).font(.largeTitle).bold().fontWidth(.standard)
            .padding(.top, 30)
            .padding(.leading, -80)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.7)) {
                    titleText = "Edit Personal Details"
                }
            }
    }

    private var image: some View {
        Image("profile")
            .resizable()
            .frame(width: 300, height: 300)
            .padding(.bottom, -100)
            .padding(.trailing, -80)
            .padding(.leading, 115)
    }
    
    private var saveButton: some View {
        UIFactory.shared.makeSaveButton {
            NetworkManager.shared.postUserDetailsRequest(fromURL: Constants.editPhoneNumber, newPhoneNumber: userModel.phoneNumber, task: userModel) { (result: Result<PersonalDetailsModel, Error>) in
                switch result {
                case .success:
                    isSheetPresented = false
                    debugPrint("Phone number edited!")
                case .failure(let error):
                    debugPrint(error.self)
                }
            }
        }
        .padding(.top, 10)
    }
    
    private var userDetails: some View {
        VStack(alignment: .leading) {
            Text("First name: \(userModel.firstName)")
                .padding(.horizontal, 50)
                .autocapitalization(.none)
                .fontWeight(.semibold)
            SeparatorView()
            Text("Last name: \(userModel.lastName)")
                .padding(.horizontal, 50)
                .autocapitalization(.none)
                .fontWeight(.semibold)
            SeparatorView()
            Text("E-mail: \(userModel.email)")
                .padding(.horizontal, 50)
                .autocapitalization(.none)
                .fontWeight(.semibold)
            SeparatorView()
            HStack(spacing: .zero) {
                Text("Phone number: ")
                    .fontWeight(.semibold)
                    .padding(.leading, 50)
                TextField(userModel.phoneNumber, text: $userModel.phoneNumber)
                    .keyboardType(.decimalPad)
                    .padding(.trailing, 50)
                    .autocapitalization(.none)
                    .fontWeight(.semibold)
                Image(systemName: "square.and.pencil")
                    .padding(.trailing, 40)
            }
            SeparatorView()
        }
        .onAppear {
            NetworkManager.shared.getProfileRequest(tab: "1", email: nil, fromURL: Constants.userProfileURL) { (result: Result<PersonalDetailsModel, Error>) in
                switch result {
                case .success(let user):
                    self.userModel = user
                    debugPrint("Succes")
                case .failure(let error):
                    debugPrint("Error \(error.localizedDescription)")
                }
            }
        }
    }
}

