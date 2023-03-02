//
//  Recipe.swift
//  SpoonRecipeDemo
//
//  Created by RAVIT SAS on 27/02/23.
//

import Foundation

struct Recipe: Codable, Identifiable, Equatable {
    let id: Int
    let title: String
    let image: String?
    let nutrition: Nutrition?
    let extendedIngredients: [Ingredient]?
    let analyzedInstructions: [Instruction]?
    
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        lhs.id == rhs.id
    }
}
