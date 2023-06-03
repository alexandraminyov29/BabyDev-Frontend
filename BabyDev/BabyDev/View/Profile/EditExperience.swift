//
//  EditExperience.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 02.06.2023.
//

import SwiftUI

struct EditExperience: View {
    
    @State var expModel: ExperienceModel = ExperienceModel()
    @State private var titleText: String = ""
    @Binding var isShowingSheetExp: Bool
    @State var email: String
    @State var index: Int
    
    var body: some View {
        ZStack {
            backgroundS
            VStack {
                title
                Spacer(minLength: .zero)
                VStack(alignment: .center) {
                    experienceDetails
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
            .padding(.leading, -140)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.7)) {
                    titleText = "Edit experience"
                }
            }
    }

    private var image: some View {
        Image("exp")
            .resizable()
            .frame(width: 300, height: 300)
            .padding(.bottom, -100)
            .padding(.trailing, -80)
            .padding(.leading, 115)
    }
    
    private var saveButton: some View {
        UIFactory.shared.makeSaveButton {
            NetworkManager.shared.editUserExperienceRequest(fromURL: Constants.experienceURL, email: "test1@gmail.com", model: expModel) { (result: Result<ExperienceModel, Error>) in
                switch result {
                case .success:
                    debugPrint("yey")
                case .failure(let error):
                    debugPrint(error.self)
                }
            }
            isShowingSheetExp = false
        }
        .padding(.top, 10)
    }
    
    private var experienceDetails: some View {
        VStack(alignment: .leading) {
                HStack(spacing: .zero) {
                    TextField(expModel.dateFrom, text: $expModel.dateFrom)
                    Text("  -  ")
                    TextField(expModel.dateTo, text: $expModel.dateTo)
                }
                .padding(.leading, 25)
                .padding(.top, 10)
                .padding(.bottom, 5)
                .font(.callout)
                .foregroundColor(.black)
                HStack {
                    Text("Title: ")
                        .padding(.leading, 50)
                        .autocapitalization(.none)
                        .fontWeight(.semibold)
                    TextField(expModel.title, text: $expModel.title)
                }
                SeparatorView()
                HStack {
                    Text("Company name: ")
                        .padding(.leading, 50)
                        .autocapitalization(.none)
                        .fontWeight(.semibold)
                    TextField(expModel.companyName, text: $expModel.companyName)
                }
                SeparatorView()
                HStack {
                    Text("Position: ")
                        .padding(.leading, 50)
                        .autocapitalization(.none)
                        .fontWeight(.semibold)
                    TextField(expModel.position, text: $expModel.position)
                }
                SeparatorView()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                NetworkManager.shared.getProfileRequest(tab: nil, email: email, fromURL: Constants.experienceURL) { (result: Result<[ExperienceModel], Error>) in
                    switch result {
                    case .success(let education):
                        self.expModel = education[index]
                        debugPrint("Succes")
                    case .failure(let error):
                        debugPrint("Error \(error.self)")
                        
                    }
                }
            }
        }
    }
}

