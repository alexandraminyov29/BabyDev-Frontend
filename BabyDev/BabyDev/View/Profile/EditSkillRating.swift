//
//  EditSkillRating.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 02.06.2023.
//

import SwiftUI

struct EditSkillRating: View {
    
    @State var skillModel: [SkillModel] = []
    @State private var titleText: String = ""
    @Binding var isShowingSheetSkill: Bool
    @State var email: String
    
    var body: some View {
        ZStack {
            backgroundS
            VStack {
                title
                Spacer(minLength: .zero)
                VStack(alignment: .center) {
                    //   saveButton
                    skillDetails
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
            .padding(.leading, -200)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.7)) {
                    titleText = "Edit skills"
                }
            }
    }
    
    private var image: some View {
        Image("skill")
            .resizable()
            .frame(width: 300, height: 300)
            .padding(.bottom, -150)
            .padding(.top, 50)
            .padding(.leading, 80)
    }
    
    private var skillDetails: some View {
        VStack(alignment: .leading) {
            ForEach(skillModel, id: \.id) { skill in
                HStack(spacing: .zero) {
                    Text(skill.skillName)
                        .font(.title3)
                    Text("  ")
                    UIFactory.shared.makeEditRating(from: stringToNumber(stringNumber: skill.skillExperience))
                }
                .padding(.top, 7)
            }
        }
        .padding(.top, -200)
        .padding(.trailing, 100)
        .padding(.leading, -50)
        .onAppear {
            getSkills()
        }
    }
    
    private func stringToNumber(stringNumber: String) -> Int {
        let lowercaseInput = stringNumber.lowercased()
        switch lowercaseInput {
        case "one":
            return 1
        case "two":
            return 2
        case "three":
            return 3
        case "four":
            return 4
        case "five":
            return 5
        default:
            return 0
        }
    }
    
    private func getSkills() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            NetworkManager.shared.getProfileRequest(tab: nil, email: email, fromURL: Constants.skillURL) { (result: Result<[SkillModel], Error>) in
                switch result {
                case .success(let skill):
                    self.skillModel = skill
                    debugPrint("Succes")
                case .failure(let error):
                    debugPrint("Error \(error.self)")
                    
                }
            }
        }
    }
}

