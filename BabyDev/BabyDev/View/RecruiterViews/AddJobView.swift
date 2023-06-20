//
//  AddJobView.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 18.06.2023.
//

import SwiftUI

struct AddJobView: View {
    
    @State var jobModel: JobModel = JobModel()
    @State private var titleText: String = ""
    @Binding var isShowingSheetAdd: Bool
    @State private var selectedValue = "Iasi"
    @State private var selectedLocation = "Full time"
    let dropdownJobType = ["Full_time",
                           "Part_time",
                           "Internship"]

    var body: some View {
        ZStack {
            backgroundS
            VStack {
                title
                VStack {
                    Spacer(minLength: .zero)
                    jobDetails
                    Spacer(minLength: .zero)
                    addButton
                }
            }
        }
    }
    
    private var backgroundS: some View {
        Color.homePageBG
            .ignoresSafeArea(.all)
            .opacity(0.6)
    }
    
    private var title: some View {
        HStack {
            Image("skill")
                .resizable()
                .frame(width: 150, height: 150)
            Spacer(minLength: .zero)
            Text(titleText).font(.largeTitle).bold().fontWidth(.standard)
                .padding(.top, 30)
                .padding(.trailing, 20)
                .onAppear {
                    withAnimation(.easeInOut(duration: 0.7)) {
                        titleText = "Add job"
                    }
                }
        }
    }
    
    private var jobDetails: some View {
        VStack {
            HStack {
                Text("Job title: ")
                    .padding(.leading, 50)
                    .autocapitalization(.none)
                    .fontWeight(.semibold)
                TextField("", text: $jobModel.title)
            }
            SeparatorView()
            HStack {
                Text("Location: ")
                    .fontWeight(.semibold)
                    .padding(.leading, 50)
                Picker("Select location", selection: $selectedLocation) {
                    ForEach(city, id: \.self) { city in
                        Text(city).tag(city)
                            .fontWeight(.semibold)
                    }
                }
                .tint(Color.black)
                .onChange(of: selectedLocation) { newLocation in
                    jobModel.location = newLocation.uppercased()
                }
                Spacer(minLength: .zero)
            }
            SeparatorView()
            HStack {
                Text("Job type: ")
                    .padding(.leading, 50)
                    .fontWeight(.semibold)
                Picker("Select type", selection: $selectedValue) {
                    ForEach(dropdownJobType, id: \.self) { type in
                        Text(type.replacing("_", with: " ")).tag(type)
                    }
                }
                .tint(Color.black)
                .onChange(of: selectedValue) { newType in
                    jobModel.type = newType
                }
                Spacer(minLength: .zero)
            }
            SeparatorView()
            HStack {
                Text("Required experience: ")
                    .padding(.leading, 50)
                    .autocapitalization(.none)
                    .fontWeight(.semibold)
                TextField("", text: $jobModel.experienceRequired)
            }
            SeparatorView()
            VStack(alignment: .leading) {
                Text("Description: ")
                    .padding(.leading, 35)
                    .padding(.top, 8)
                    .fontWeight(.semibold)
                TextEditor(text: $jobModel.description)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 350, height: 150)
                    .lineLimit(100)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 50)
                    .padding(.bottom, 10)
            }
            SeparatorView()
        }
    }
    
    private var addButton: some View {
        UIFactory.shared.makeAddJobButton {
            NetworkManager.shared.addJobRequest(fromURL: Constants.addJobURL, model: jobModel) { (result: Result<JobModel, Error>)  in
                switch result {
                case .success:
                    debugPrint("yey")
                case .failure(let error):
                    debugPrint(error.self)
                }
            }
            isShowingSheetAdd = false
        }
    }
    
    // GENERATED WITH CHAT GPT
    let city = [
        "Iasi",
        "Arad",
        "Pitesti",
        "Bacau",
        "Oradea",
        "Bistrita",
        "Botosani",
        "Brasov",
        "Braila",
        "Buzau",
        "Resita",
        "Cluj-Napoca",
        "Constanta",
        "Sfantu Gheorghe",
        "Targu Mures",
        "Craiova",
        "Piatra Neamt",
        "Targu Jiu",
        "Deva",
        "Slobozia",
        "Suceava",
        "Alexandria",
        "Timisoara",
        "Tulcea",
        "Vaslui",
        "Ramnicu Valcea",
        "Focsani",
        "Galati",
        "Giurgiu",
        "Miercurea Ciuc",
        "Slatina",
        "Ploiesti",
        "Zalau",
        "Sibiu",
        "Calarasi",
        "Satu Mare",
        "Sighetu Marmatiei",
        "Drobeta-Turnu Severin",
        "Radauti"
    ]
}
