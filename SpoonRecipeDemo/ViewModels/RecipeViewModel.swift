//
//  RecipeViewModel.swift
//  SpoonRecipeDemo
//
//  Created by Ravit on 27/02/23.
//

import Foundation
import SwiftUI

class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var errorMessage: String = ""
    @Published var isLoading = false
    init() {
        fetchRecipes()
    }
    
    func fetchRecipes() {
        self.isLoading = true
        APIManager.shared.fetchRecipes(endpoint: Endpoint.randomRecipes, parameters: ["number": 20]) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let recipes):
                    self.recipes = recipes
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
