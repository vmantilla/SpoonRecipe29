//
//  FavoritesViewModel.swift
//  SpoonRecipeDemo
//
//  Created by Ravit on 27/02/23.
//

import Foundation

class FavoritesViewModel: ObservableObject {
    
    @Published var recipes: [Recipe] = []
    @Published var errorMessage: String = ""
    
    init() {
        fetchFavoriteRecipes()
    }
    
    func fetchFavoriteRecipes() {
        self.recipes = PersistenceManager.shared.fetchFavoriteRecipes()
    }
    
    func removeFavoriteRecipe(_ recipe: Recipe) {
        PersistenceManager.shared.removeFavoriteRecipe(recipe)
        objectWillChange.send()
    }
}
