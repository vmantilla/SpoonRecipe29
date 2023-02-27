//
//  Recipe.swift
//  SpoonRecipeDemo
//
//  Created by RAVIT SAS on 27/02/23.
//

import Foundation

struct Recipe: Codable, Identifiable {
    let id: Int
    let title: String
    let summary: String?
    let image: String?
    let nutrition: Nutrition?
    let extendedIngredients: [Ingredient]?
    let analyzedInstructions: [Instruction]?
}
