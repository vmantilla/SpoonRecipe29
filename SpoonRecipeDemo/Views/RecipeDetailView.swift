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
    
    var body: some View {
        VStack(alignment: .leading) {
            if let imageURL = URL(string: recipe.image ?? "") {
                AsyncImage(url: imageURL)
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .frame(maxWidth: .infinity)
            }
            Text(recipe.title)
                .font(.title)
                .padding(.vertical)
            
            if let ingredients = viewModel.recipe?.extendedIngredients {
                VStack(alignment: .leading) {
                    Text("Ingredients:")
                        .font(.headline)
                        .padding(.bottom, 8)
                    ForEach(ingredients, id: \.id) { ingredient in
                        Text(ingredient.originalString ?? "")
                    }
                }
                .padding(.bottom)
            }
            
            if let instructions = viewModel.recipe?.analyzedInstructions {
                VStack(alignment: .leading) {
                    Text("Instructions:")
                        .font(.headline)
                        .padding(.bottom, 8)
                    ForEach(instructions, id: \.id) { instruction in
                        VStack(alignment: .leading) {
                            Text(instruction.name)
                                .font(.subheadline)
                                .padding(.bottom, 4)
                            ForEach(instruction.steps, id: \.number) { step in
                                HStack(alignment: .top) {
                                    Text("\(step.number).")
                                        .bold()
                                    Text(step.step)
                                }
                                .padding(.bottom, 4)
                            }
                        }
                    }
                }
            }
            Spacer()
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(recipe.title)
        .onAppear {
            self.viewModel.getRecipeDetails(for: recipe)
        }
    }
}
