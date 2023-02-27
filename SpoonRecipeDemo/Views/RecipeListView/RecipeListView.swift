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
    @State private var showError = false
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
                    .padding()
            } else if !viewModel.errorMessage.isEmpty {
                HStack {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.white)
                    Button(action: {
                        self.viewModel.errorMessage = ""
                        self.viewModel.fetchRecipes()
                    }) {
                        Label("Reload", systemImage: "arrow.clockwise")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                    .padding(.leading, 8)
                }
                .padding()
                .background(Color.red)
                .cornerRadius(8)
                .padding()
                .onAppear {
                    self.showError = true
                }
            }
            List(viewModel.recipes) { recipe in
                Button(action: {
                    self.coordinator.showFavoritesView()
                }) {
                    RecipeRowView(recipe: recipe)
                }
            }
        }
        .navigationTitle("Recipes")
        .onAppear {
            self.viewModel.fetchRecipes()
        }
    }
}

