//
//  PersonalDetailsTab.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 27.05.2023.
//

import SwiftUI

struct PersonalDetails: View {
    
    @State var userModel: [PersonalDetailsModel] = []
    @State var educationModel: [EducationModel] = []
    @State var experienceModel: [ExperienceModel] = []
    @State var skillModel: [SkillModel] = []
    @State var skillNames: [String] = []
    @State var email: String = ""
    @State var id: String = ""
    @State var idExp: String = ""
    @State var idSkill: String = ""
    @State private var isShowingSheet: Bool = false
    @State private var isShowingSheetExp: Bool = false
    @State private var isShowingSheetEdu: Bool = false
    @State private var isShowingSheetAddEdu: Bool = false
    @State private var isShowingSheetAddExp: Bool = false
    @State private var isShowingSheetSkill: Bool = false
    @State private var isShowingSheetAddSkill: Bool = false
    @State private var selectedCard: Int = 1
    @State private var selectedImage: Image?
    @State private var isShowingImagePicker = false
    @State private var selectedIndex: Int = 0
    @State private var selectedIndexExp: Int = 0
    @State private var showDeleteEducationAlert = false
    @State private var showDeleteExperienceAlert = false
    @State private var showDeleteSkillAlert = false
    @State private var redirectToLogin = false

    
    var body: some View {
        VStack {
            userImage
            userName
        }
        Spacer(minLength: .zero)
        ScrollView() {
            VStack() {
                userPersonalDetails
                educationDetails
                experienceDetails
                skillDetails
                logoffButton
            }
            .padding(.bottom, 30)
            .edgesIgnoringSafeArea(.bottom)
        }
        .frame(height: 600)
    }
    
    private var userImage: some View {
        VStack {
            if let image = base64ToImage(base64String: userModel.first?.imageData ?? "")
                ?? Image("img") {
                Button(action: {
                    isShowingImagePicker = true
                }) {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 130, height: 130)
                        .clipShape(Capsule(style: .circular))
                        .shadow(color: .black, radius: 5)
                }
                
            }
        }
        .onAppear {
            getUserDetails()
        }
        .sheet(isPresented: $isShowingImagePicker, onDismiss: {
            if let image = selectedImage {
                let imageToData = image.asUIImage()
                let img: Data = imageToData.jpegData(compressionQuality: 0.1) ?? Data()
                let imageBytes = img.withUnsafeBytes {
                    [UInt8](UnsafeBufferPointer(start: $0, count: img.count))
                }
                NetworkManager.shared.addUserPhotoRequest(fromURL: Constants.addUserPhoto, array: imageBytes) {  (result: Result<PersonalDetailsModel, Error>) in
                    switch result {
                    case .success:
                        debugPrint("Success")
                    case .failure(let error):
                        debugPrint("We got a failure trying to post. The error we got was: \(error)")}
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                getUserDetails()
            }
            
        }) {
            ImagePicker(selectedImage: $selectedImage, showImgPicker: $isShowingImagePicker)
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
                    .padding(.leading, 190)
                Image(systemName: "square.and.pencil")
                    .foregroundColor(Color.lightPurple)
                    .padding(.bottom, 15)
                    .onTapGesture {
                        isShowingSheet = true
                    }
                    .sheet(isPresented: $isShowingSheet, onDismiss: {
                        getUserDetails()
                    }) {
                        EditPersonalDetails(isSheetPresented: $isShowingSheet)
                    }
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
    
    private var educationDetails: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Education")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding(.bottom, 15)
                    .padding(.leading, 245)
                Image(systemName: "plus.app")
                    .foregroundColor(Color.lightPurple)
                    .padding(.bottom, 15)
                    .onTapGesture {
                        isShowingSheetAddEdu = true
                    }
                    .sheet(isPresented: $isShowingSheetAddEdu, onDismiss: {
                        getEducationDetails()
                    }) {
                        AddEducation(isShowingSheetAddEdu: $isShowingSheetAddEdu, email: email)
                    }
            }
            SeparatorView()
                .padding(.top, -14)
                .frame(width: 400)
                .padding(.trailing, 30)
            ForEach(Array(educationModel.enumerated()), id: \.element.id) { index, edu in
                HStack(spacing: .zero) {
                    Text(edu.dateFrom)
                    Text("  -  ")
                    Text(edu.dateTo == "actual" ? "Present" : edu.dateTo)
                }
                .padding(.leading, 25)
                .padding(.top, 10)
                .padding(.bottom, 5)
                .font(.callout)
                .foregroundColor(.gray)
                
                HStack(spacing: .zero) {
                    Text("Institution: ")
                    Text(edu.institution)
                }
                .padding(.leading, 25)
                .font(.title3)
                .foregroundColor(.black)
                
                HStack(spacing: .zero) {
                    Text("Subject: ")
                    Text(edu.subject)
                }
                .padding(.leading, 25)
                .font(.title3)
                .foregroundColor(.black)
                
                HStack(spacing: .zero) {
                    Text("Degree: ")
                    Text(edu.degree == "HIGH_SCHOOL_GRADUATION_DIPLOMA" ? "DIPLOMA" : edu.degree)
                }
                .font(.title3)
                .foregroundColor(.black)
                .padding(.leading, 25)
                HStack {
                    Image(systemName: "square.and.pencil")
                        .foregroundColor(Color.lightPurple)
                        .padding(.top, -70)
                        .padding(.leading, 300)
                        .onTapGesture {
                            isShowingSheetEdu = true
                            selectedIndex = index
                        }
                        .sheet(isPresented: $isShowingSheetEdu, onDismiss: {
                            getEducationDetails()
                        }) {
                            EditEducation(isShowingSheetEdu: $isShowingSheetEdu, email: email, index: selectedIndex)
                        }
                    Image(systemName: "trash")
                        .foregroundColor(Color.lightPurple)
                        .padding(.top, -70)
                        .onTapGesture {
                            showDeleteEducationAlert = true
                        }
                        .alert(isPresented: $showDeleteEducationAlert) {
                            Alert(
                                title: Text("Confirmation"),
                                message: Text("Are you sure you want to delete?"),
                                primaryButton: .destructive(Text("Delete")) {
                                    NetworkManager.shared.removeUserEducationRequest(fromURL: Constants.educationURL, email: email, id: id) { (result: Result<[EducationModel], Error>) in
                                        switch result {
                                        case .success(let edu):
                                            self.educationModel = edu
                                            debugPrint("Succes")
                                        case .failure(let error):
                                            debugPrint("Error \(error.self)")
                                        }
                                    }
                                    getEducationDetails()
                                },
                                secondaryButton: .cancel()
                            )
                        }
                }
                .padding(.leading, 15)
            }
            
        }
        .padding(.leading, 30)
        .onAppear {
            getEducationDetails()
        }
        .padding(.top, 35)
    }
    
    private var experienceDetails: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Experience")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding(.bottom, 15)
                    .padding(.leading, 232)
                Image(systemName: "plus.app")
                    .foregroundColor(Color.lightPurple)
                    .padding(.bottom, 15)
                    .onTapGesture {
                        isShowingSheetAddExp = true
                    }
                    .sheet(isPresented: $isShowingSheetAddExp, onDismiss: {
                        getExpDetails()
                    }) {
                        AddExperience(isShowingSheetAddExp: $isShowingSheetAddExp, email: email)
                    }
            }
            SeparatorView()
                .padding(.top, -14)
                .frame(width: 400)
            ForEach(Array(experienceModel.enumerated()), id: \.element.id) { index, exp in
                HStack(spacing: .zero) {
                    Text(exp.dateFrom)
                    Text("  -  ")
                    Text(exp.dateTo == "actual" ? "Present" : exp.dateTo)
                }
                .font(.callout)
                .foregroundColor(.gray)
                .padding(.top, 10)
                .padding(.bottom, 5)
                
                HStack(spacing: .zero) {
                    Text("Title: ")
                    Text(exp.title)
                }
                .font(.title3)
                .foregroundColor(.black)
                
                HStack(spacing: .zero) {
                    Text("Company name: ")
                    Text(exp.companyName)
                }
                .font(.title3)
                .foregroundColor(.black)
                
                HStack(spacing: .zero) {
                    Text("Position: ")
                    Text(exp.position)
                }
                .font(.title3)
                .foregroundColor(.black)
                
                HStack {
                    Image(systemName: "square.and.pencil")
                        .foregroundColor(Color.lightPurple)
                        .padding(.top, -70)
                        .padding(.leading, 300)
                        .onTapGesture {
                            isShowingSheetExp = true
                            selectedIndexExp = index
                        }
                        .sheet(isPresented: $isShowingSheetExp, onDismiss: {
                            getExpDetails()
                        }) {
                            EditExperience(isShowingSheetExp: $isShowingSheetExp, email: email, index: selectedIndexExp)
                        }
                    Image(systemName: "trash")
                        .foregroundColor(Color.lightPurple)
                        .padding(.top, -70)
                        .onTapGesture {
                            showDeleteExperienceAlert = true
                        }
                        .alert(isPresented: $showDeleteExperienceAlert) {
                            Alert(
                                title: Text("Confirmation"),
                                message: Text("Are you sure you want to delete?"),
                                primaryButton: .destructive(Text("Delete")) {
                                    NetworkManager.shared.removeUserEducationRequest(fromURL: Constants.experienceURL, email: email, id: idExp) { (result: Result<[ExperienceModel], Error>) in
                                        switch result {
                                        case .success(let exp):
                                            self.experienceModel = exp
                                            debugPrint("Succes")
                                        case .failure(let error):
                                            debugPrint("Error \(error.self)")
                                        }
                                    }
                                    getExpDetails()
                                },
                                secondaryButton: .cancel()
                            )
                        }
                }
                .padding(.leading, -14)
            }
            .padding(.leading, 30)
        }
        .padding(.top, 35)
        .onAppear {
            getExpDetails()
        }
    }
    
    private var skillDetails: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Skills")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding(.bottom, 15)
                    .padding(.leading, 286)
                HStack {
                    Image(systemName: "plus.app")
                        .foregroundColor(Color.lightPurple)
                        .padding(.bottom, 15)
                        .onTapGesture {
                            isShowingSheetAddSkill = true
                        }
                        .sheet(isPresented: $isShowingSheetAddSkill, onDismiss: {
                            getSkills()
                        }) {
                            AddSkill(isShowingSheetAddSkill: $isShowingSheetAddSkill, email: email)
                        }
                }
            }
            SeparatorView()
                .padding(.top, -14)
                .frame(width: 400)
            ForEach(skillModel, id: \.id) { skill in
                HStack(spacing: .zero) {
                    Text(skill.skillName)
                        .font(.title3)
                        .frame(width: 90, alignment: .leading)
                    Text("  ")
                    UIFactory.shared.makeRating(from: stringToNumber(stringNumber: skill.skillExperience))
                    HStack(spacing: .zero) {
                        Text("       ")
                        Image(systemName: "trash")
                            .foregroundColor(Color.lightPurple)
                            .onTapGesture {
                                showDeleteSkillAlert = true
                            }
                            .alert(isPresented: $showDeleteSkillAlert) {
                                Alert(
                                    title: Text("Confirmation"),
                                    message: Text("Are you sure you want to delete?"),
                                    primaryButton: .destructive(Text("Delete")) {
                                        NetworkManager.shared.removeUserEducationRequest(fromURL: Constants.skillURL, email: email, id: idSkill) { (result: Result<[SkillModel], Error>) in
                                            switch result {
                                            case .success(let skill):
                                                self.skillModel = skill
                                                debugPrint("Succes")
                                            case .failure(let error):
                                                debugPrint("Error \(error.self)")
                                            }
                                        }
                                        getSkills()
                                    },
                                    secondaryButton: .cancel()
                                )
                            }
                    }
                    .padding(.leading, 40)
                }
                .padding(.top, 2)
                .padding(.leading, 30)
            }
        }
        .onAppear {
            getSkills()
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
    
    private func getUserDetails() {
        NetworkManager.shared.getProfileRequest(tab: "1", email: nil, fromURL: Constants.userProfileURL) { (result: Result<PersonalDetailsModel, Error>) in
            switch result {
            case .success(let user):
                self.userModel = [user]
                self.email = userModel.first?.email ?? ""
                debugPrint("Succes")
            case .failure(let error):
                debugPrint("Error \(error.localizedDescription)")
                
            }
        }
    }
    
    private func getEducationDetails() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            NetworkManager.shared.getProfileRequest(tab: nil, email: email, fromURL: Constants.educationURL) { (result: Result<[EducationModel], Error>) in
                switch result {
                case .success(let education):
                    self.educationModel = education
                    self.id = educationModel.first?.id.description ?? ""
                    debugPrint("Succes")
                case .failure(let error):
                    debugPrint("Error \(error.self)")
                    
                }
            }
        }
    }
    
    private func getExpDetails() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            NetworkManager.shared.getProfileRequest(tab: nil, email: email, fromURL: Constants.experienceURL) { (result: Result<[ExperienceModel], Error>) in
                switch result {
                case .success(let experience):
                    self.experienceModel = experience
                    self.idExp = experienceModel.first?.id.description ?? ""
                    debugPrint("Succes")
                case .failure(let error):
                    debugPrint("Error \(error)")
                    
                }
            }
        }
    }
    
    private func getSkills() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            NetworkManager.shared.getProfileRequest(tab: nil, email: email, fromURL: Constants.skillURL) { (result: Result<SkillFullModel, Error>) in
                switch result {
                case .success(let skill):
                    self.skillModel = skill.skills
                    self.skillNames = skill.skillNames
                    self.idSkill = skillModel.first?.id.description ?? ""
                    debugPrint("Succes")
                case .failure(let error):
                    debugPrint("Error \(error.self)")
                    
                }
            }
        }
    }
}
