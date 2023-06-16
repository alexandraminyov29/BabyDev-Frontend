//
//  AddEducation.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 02.06.2023.
//

import SwiftUI

struct AddEducation: View {
    
    @State var educationModel: EducationModel = EducationModel()
    @State private var titleText: String = ""
    @Binding var isShowingSheetAddEdu: Bool
    @State var email: String
    @State private var selectedValue = ""
    @State private var selectedDateFrom = Date()
    @State private var selectedDateTo = Date()
    let dropdown = ["HIGH_SCHOOL_GRADUATION_DIPLOMA", "BACHELOR", "MASTER"]
    
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
                    titleText = "Add education"
                }
            }
    }

    private var image: some View {
        Image("education")
            .resizable()
            .frame(width: 300, height: 300)
            .padding(.bottom, -100)
            .padding(.trailing, -80)
            .padding(.leading, 115)
    }
    
    private var saveButton: some View {
        UIFactory.shared.makeSaveButton {
            NetworkManager.shared.addUserEducationRequest(fromURL: Constants.educationURL, email: email, model: educationModel) { (result: Result<[EducationModel], Error>) in
                switch result {
                case .success:
                    debugPrint("yey")
                case .failure(let error):
                    debugPrint(error.self)
                }
            }
            isShowingSheetAddEdu = false
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
                        educationModel.dateFrom = formatDate(date: newDate)
                    }
                Text ("-")
                DatePicker("", selection: $selectedDateTo, displayedComponents: .date)
                    .datePickerStyle(.compact)
                    .padding(.trailing, 75)
                    .onChange(of: selectedDateTo) { newDate in
                        educationModel.dateTo = formatDate(date: newDate)
                    }
            }
            .font(.callout)
            .foregroundColor(.gray)
            .padding(.leading, 35)
            .padding(.bottom, 20)
            HStack {
                Text("Institution: ")
                    .padding(.leading, 50)
                    .autocapitalization(.none)
                    .fontWeight(.semibold)
                TextField("", text: $educationModel.institution)
            }
            SeparatorView()
            HStack {
                Text("Subject: ")
                    .padding(.leading, 50)
                    .autocapitalization(.none)
                    .fontWeight(.semibold)
                TextField("", text: $educationModel.subject)
            }
            SeparatorView()
            HStack {
                Text("Degree: ")
                    .padding(.leading, 50)
                    .autocapitalization(.none)
                    .fontWeight(.semibold)
                Picker("Select a degree", selection: $selectedValue) {
                        ForEach(dropdown, id: \.self) { degree in
                            Text(degree).tag(degree)
                        }
                    }
                .onChange(of: selectedValue) { newValue in
                    educationModel.degree = newValue
                }
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
