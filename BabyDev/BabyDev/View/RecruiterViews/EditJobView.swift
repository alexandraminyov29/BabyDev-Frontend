//
//  EditJobView.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 19.06.2023.
//

import SwiftUI

struct EditJobView: View {
    
    @State var jobModel: JobModel = JobModel()
    @StateObject var jobVM: JobCardVM = JobCardVM()
    @State private var titleText: String = ""
    @Binding var isShowingSheetEdit: Bool
    @State var jobId: Int = 0
    @State private var selectedType = ""
    @State private var selectedLocation = ""
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
                    editButton
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
                        titleText = "Edit job"
                    }
                }
        }
    }
    
    private var jobDetails: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Job title: ")
                    .padding(.leading, 50)
                    .fontWeight(.semibold)
                TextField("\(jobModel.title)", text: $jobModel.title)
            }
            SeparatorView()
            HStack {
                Text("Location: ")
                    .padding(.leading, 50)
                    .fontWeight(.semibold)
                Picker("Select location", selection: $selectedLocation) {
                    ForEach(city, id: \.self) { city in
                        Text(city).tag(city)
                            .fontWeight(.semibold)
                    }
                    Spacer(minLength: .zero)
                }
                .tint(Color.black)
                .onChange(of: selectedLocation) { newLocation in
                    jobModel.location = newLocation.uppercased()
                }
            }
            SeparatorView()
            HStack {
                Text("Job type: ")
                    .padding(.leading, 50)
                    .fontWeight(.semibold)
                Picker("Select type", selection: $selectedType) {
                    ForEach(dropdownJobType, id: \.self) { type in
                        Text(type.replacing("_", with: " ")).tag(type)
                            .fontWeight(.semibold)
                            .padding(.leading, -50)
                    }
                }
                .tint(Color.black)
                .onChange(of: selectedType) { newType in
                    jobModel.type = newType
                }
            }
            SeparatorView()
            HStack {
                Text("Required experience: ")
                    .padding(.leading, 50)
                    .fontWeight(.semibold)
                TextField("\(jobModel.experienceRequired)", text: $jobModel.experienceRequired)
            }
            SeparatorView()
            VStack(alignment: .leading) {
                Text("Description: ")
                    .padding(.leading, 50)
                    .padding(.top, 8)
                    .fontWeight(.semibold)
                TextEditor(text: $jobModel.description)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 350, height: 200)
                    .lineLimit(100)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 50)
                    .padding(.bottom, 10)
            }
            SeparatorView()
        }
        .onAppear {
            getJobs()
        }
    }
    
    private var editButton: some View {
        UIFactory.shared.makeEditJobButton {
            NetworkManager.shared.editJobRequest(fromURL: Constants.editJobURL, jobId: jobId, model: jobModel) { (result: Result<JobModel, Error>)  in
                switch result {
                case .success:
                    debugPrint("yey")
                case .failure(let error):
                    debugPrint(error.self)
                }
            }
            isShowingSheetEdit = false
        }
    }
    
    private func getJobs() {
        NetworkManager.shared.getJobDetailsRequest(id: jobId, fromURL: Constants.jobDetails) { (result: Result<JobModel, Error>) in
            switch result {
            case .success(let job):
                jobModel = job
            case .failure(let failure):
                debugPrint(failure.self)
            }
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

