//
//  UIFactory.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 02.05.2023.
//

import SwiftUI

class UIFactory {
    
    private init() {}
    
    static let shared = UIFactory()
    
    
    
    // MARK: BUTTONS
    
//static func primaryButton(title: String, action: @escaping () -> Void) -> some View {
//    Button(action: action) {
//
//    }
//}

    // MARK: JOB CARDS
    
    func makeJobCardView(from jobModel: JobListViewModel) -> some View {
        return JobCardView(job: jobModel)
    }
    
    // MARK: SEARCH BAR
    
    func makeSearchBarView(from text: Binding<String>) -> some View {
        return SearchBar(text: text)
    }
}
