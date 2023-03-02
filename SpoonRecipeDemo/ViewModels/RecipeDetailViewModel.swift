//
//  RecipeDetailViewModel.swift
//  SpoonRecipeDemo
//
//  Created by RAVIT SAS on 27/02/23.
//

import SwiftUI
import Combine

class RecipeDetailViewModel: ObservableObject {
    @Published var recipe: Recipe?
    @Published var errorMessage: String = ""
    @Published var isLoading = false
    
    let apiManager: APIManagerProtocol
    
    init(apiManager: APIManagerProtocol = APIManager()) {
        self.apiManager = apiManager
    }
    
    func getRecipeDetails(for recipe: Recipe) {
        self.errorMessage = ""
        self.isLoading = true
        
        apiManager.getRecipe(identifier: recipe.id) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let recipes):
                    self.recipe = recipes
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
