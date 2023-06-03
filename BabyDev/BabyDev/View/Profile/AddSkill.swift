//
//  AddSkill.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 03.06.2023.
//

import SwiftUI

struct AddSkill: View {
    
    @State var skillModel : SkillModel = SkillModel()
    @State private var titleText: String = ""
    @State private var selectedValue = ""
    @Binding var isShowingSheetAddSkill: Bool
    @State var email: String
    let dropdown = ["ONE", "TWO", "THREE", "FOUR", "FIVE"]
    
    var body: some View {
        ZStack {
            backgroundS
            VStack {
                title
                Spacer(minLength: .zero)
                VStack(alignment: .center) {
                    skillDetails
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
            .padding(.leading, -180)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.7)) {
                    titleText = "Add skill"
                }
            }
    }
    
    private var image: some View {
        Image("skil")
            .resizable()
            .frame(width: 300, height: 300)
            .padding(.bottom, -100)
            .padding(.trailing, -80)
            .padding(.leading, 115)
    }
    
    private var saveButton: some View {
        UIFactory.shared.makeSaveButton {
            NetworkManager.shared.addUserSkillRequest(fromURL: Constants.skillURL, email: email, model: skillModel) { (result: Result<[SkillModel], Error>) in
                switch result {
                case .success:
                    debugPrint("yey")
                case .failure(let error):
                    debugPrint(error.self)
                }
            }
            isShowingSheetAddSkill = false
        }
        .padding(.top, 10)
    }
    
    private var skillDetails: some View {
        VStack(alignment: .leading) {
            TextField("Skill: ", text: $skillModel.skillName)
                .padding(.leading, 35)
            SeparatorView()
            Picker("Select skill level: ", selection: $selectedValue) {
                ForEach(dropdown, id:\.self) { level in
                    Text(level).tag(level)
                }
            }
            .padding(.leading, 150)
            .onChange(of: selectedValue) { newLevel in
                skillModel.skillExperience = newLevel
            }
        }
        .padding(.leading, 25)
    }
}

