//
//  SearchViewModel.swift
//  SpoonRecipeDemo
//
//  Created by Ravit on 27/02/23.
//

import SwiftUI
import Combine

class SearchViewModel: ObservableObject {
    
    @Published var keyword = ""
    @Published var recipes = [Recipe]()
    @Published var errorMessage = ""
    @Published var isLoading = false
    
    let apiManager: APIManagerProtocol
    
    init(apiManager: APIManagerProtocol = APIManager()) {
        self.apiManager = apiManager
    }
    
    func searchRecipes() {
        guard !keyword.isEmpty else {
            return
        }
        self.recipes.removeAll()
        self.errorMessage = ""
        self.isLoading = true
        
        apiManager.fetchRecipes(
            endpoint: Endpoint.searchRecipes,
            parameters: ["query": keyword,"number": 20]) { result in
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
