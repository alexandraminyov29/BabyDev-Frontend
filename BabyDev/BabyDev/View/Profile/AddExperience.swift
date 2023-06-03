//
//  AddExperience.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 03.06.2023.
//

import SwiftUI

struct AddExperience: View {
    
    @State var experienceModel: ExperienceModel = ExperienceModel()
    @State private var titleText: String = ""
    @Binding var isShowingSheetAddExp: Bool
    @State var email: String
    @State private var selectedDateFrom = Date()
    @State private var selectedDateTo = Date()
    
    var body: some View {
        ZStack {
            backgroundS
            VStack {
                title
                Spacer(minLength: .zero)
                VStack(alignment: .center) {
                    educationDetails
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
                    titleText = "Add experience"
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
            NetworkManager.shared.addUserExperienceRequest(fromURL: Constants.experienceURL, email: email, model: experienceModel) { (result: Result<[ExperienceModel], Error>) in
                switch result {
                case .success:
                    debugPrint("yey")
                case .failure(let error):
                    debugPrint(error.self)
                }
            }
            isShowingSheetAddExp = false
        }
        .padding(.top, 10)
    }
    
    private var educationDetails: some View {
        VStack(alignment: .leading) {
            Text("Select date:")
                .font(.callout)
                .padding(.leading, 180)
            HStack {
                DatePicker("", selection: $selectedDateFrom, displayedComponents: .date)
                    .datePickerStyle(.automatic)
                    .padding(.leading, 30)
                    .onChange(of: selectedDateFrom) { newDate in
                        experienceModel.dateFrom = formatDate(date: newDate)
                    }
                Text ("-")
                DatePicker("", selection: $selectedDateTo, displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .padding(.trailing, 75)
                    .onChange(of: selectedDateTo) { newDate in
                        experienceModel.dateTo = formatDate(date: newDate)
                    }
            }
            .font(.callout)
            .foregroundColor(.gray)
            .padding(.leading, 35)
            .padding(.bottom, 20)
            HStack {
                Text("Title: ")
                    .padding(.leading, 50)
                    .autocapitalization(.none)
                    .fontWeight(.semibold)
                TextField("", text: $experienceModel.title)
            }
            SeparatorView()
            HStack {
                Text("Company name: ")
                    .padding(.leading, 50)
                    .autocapitalization(.none)
                    .fontWeight(.semibold)
                TextField("", text: $experienceModel.companyName)
            }
            SeparatorView()
            HStack {
                Text("Position: ")
                    .padding(.leading, 50)
                    .autocapitalization(.none)
                    .fontWeight(.semibold)
                TextField("", text: $experienceModel.position)
            }
            SeparatorView()
        }
    }
    
    func formatDate(date: Date) -> String {
        
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "dd-MM-yyyy"
          return dateFormatter.string(from: date)
        
      }
}
