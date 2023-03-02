//
//  FavoriteRecipesView.swift
//  SpoonRecipeDemo
//
//  Created by Ravit on 27/02/23.
//

import Foundation
import SwiftUI

struct FavoriteRecipesView: View {
    @EnvironmentObject var coordinator: Coordinator
    @ObservedObject var viewModel: FavoritesViewModel
    
    var body: some View {
        List(viewModel.recipes) { recipe in
            RecipeRowView(recipe: recipe)
                .contextMenu {
                    Button(action: {
                        viewModel.removeFavoriteRecipe(recipe)
                        viewModel.fetchFavoriteRecipes()
                    }) {
                        Text("Remove from Favorites")
                        Image(systemName: "trash")
                    }
                }
                .onTapGesture {
                    self.coordinator.showRecipeDetailView(for: recipe)
                }
        }
        .onAppear {
            viewModel.fetchFavoriteRecipes()
        }
        .navigationTitle("Favorite Recipes")
    }
}

