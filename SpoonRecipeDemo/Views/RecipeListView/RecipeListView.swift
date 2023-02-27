//
//  RecipeListView.swift
//  SpoonRecipeDemo
//
//  Created by Ravit on 27/02/23.
//

import SwiftUI
struct RecipeListView: View {
    
    @EnvironmentObject var coordinator: Coordinator
    @ObservedObject var viewModel: RecipeViewModel
    
    var body: some View {
        List(viewModel.recipes) { recipe in
            Button(action: {
                self.coordinator.showFavoritesView()
            }) {
                RecipeRowView(recipe: recipe)
            }
        }
        .navigationTitle("Recipes")
    }
}
