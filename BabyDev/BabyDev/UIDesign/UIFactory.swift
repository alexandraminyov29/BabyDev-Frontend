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
    
    // FAVORITE BUTTON
    func makeFavoriteButton(isFavorite: Bool, action: @escaping () -> Void) -> some View {
        return FavoriteButton(isFavorite: isFavorite, action: action)
    }
    
    // APPLY JOB BUTTON
    func makeApplyButton(action: @escaping () -> Void) -> some View {
        return ApplyButton(action: action)
    }
    
    // BACK BUTTON
    func makeBackButton<Destination: View>(destination: Destination) -> some View {
        return BackButton(destination: destination)
    }
    
    // SAVE BUTTON
    func makeSaveButton(action: @escaping () -> Void) -> some View {
        return SaveButton(action: action)
    }

    // MARK: JOB CARDS
    
    func makeJobCardView(from jobModel: JobListViewModel) -> some View {
        return Jobcard(job: jobModel)
    }
    
    // MARK: SEARCH BAR
    
    func makeSearchBarView(from text: Binding<String>) -> some View {
        return SearchBar(text: text)
    }
    
    // MARK: FILTER TABS
    
    func makeFilterTab(from text: String) -> some View {
        return FilterTab(text: text)
    }
    
    // MARK: STAR RATING
    
    func makeRating(from ratingNumber: Int) -> some View {
        return StarRating(ratingNumber: ratingNumber)
    }
    
    func makeEditRating(from ratingNumber: Int) -> some View {
        return ModifyStarRating(ratingNumber: ratingNumber)
    }
}
