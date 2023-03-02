//
//  RecipeDetailView.swift
//  SpoonRecipeDemo
//
//  Created by RAVIT SAS on 27/02/23.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    @ObservedObject private var viewModel = RecipeDetailViewModel()
    @State private var isFavorite = false

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    if let imageURL = URL(string: recipe.image ?? "") {
                        AsyncImage(url: imageURL)
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: UIScreen.main.bounds.width - 50)
                            .padding(10)
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .frame(maxWidth: UIScreen.main.bounds.width - 50)
                            .padding(10)
                    }
                    Text(recipe.title)
                        .font(.title)
                        .padding(.vertical)

                    Button(action: {
                        if self.isFavorite {
                            PersistenceManager.shared.removeFavoriteRecipe(self.recipe)
                        } else {
                            PersistenceManager.shared.saveRecipe(self.recipe)
                        }
                        self.isFavorite.toggle()
                    }) {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(isFavorite ? .red : .black)
                            .padding()
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    }
                    Spacer()
                    
                    if let ingredients = viewModel.recipe?.extendedIngredients {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Ingredients:")
                                .font(.headline)
                            ForEach(ingredients, id: \.id) { ingredient in
                                HStack(alignment: .top) {
                                    Text("-")
                                    Text(ingredient.name)
                                }
                            }
                        }
                        .padding(.bottom)
                    }

                    if let instructions = viewModel.recipe?.analyzedInstructions {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Instructions:")
                                .font(.headline)
                            ForEach(instructions, id: \.id) { instruction in
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(instruction.name)
                                        .font(.subheadline)
                                    ForEach(instruction.steps, id: \.number) { step in
                                        HStack(alignment: .top) {
                                            Text("\(step.number).")
                                                .bold()
                                            Text(step.step)
                                        }
                                        .padding(.bottom, 4)
                                    }
                                }
                                .padding(.bottom, 8)
                            }
                        }
                    }
                }
                .padding()
                .frame(maxWidth: geometry.size.width)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(recipe.title)
        .onAppear {
            self.viewModel.getRecipeDetails(for: recipe)
            self.isFavorite = PersistenceManager.shared.fetchFavoriteRecipes().contains { $0.id == self.recipe.id }
        }
    }
}
