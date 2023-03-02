//
//  File.swift
//  SpoonRecipeDemoTests
//
//  Created by RAVIT SAS on 1/03/23.
//

import Foundation
@testable import SpoonRecipeDemo

class MockAPIManager: APIManagerProtocol {
    
    let returnError: Bool
    
    init(returnError: Bool = false) {
        self.returnError = returnError
    }
    
    func fetchRecipes(endpoint: String, parameters: [String: Any], completion: @escaping (Result<[Recipe], APIError>) -> Void) {
        if returnError {
            completion(.failure(.serverError(message: "An error occurred")))
        } else {
            let nutrition = Nutrition(nutrients: [])
            let ingredient = Ingredient(id: 0, name: "Example Ingredient")
            let analyzedInstruction = Instruction(id: 0, name: "Example Instruction", steps: [])
            let recipe = Recipe(id: 123, title: "Example Recipe", image: "example.png", nutrition: nutrition, extendedIngredients: [ingredient], analyzedInstructions: [analyzedInstruction])

            completion(.success([recipe, recipe]))
        }
    }
    
    func getRecipe(identifier: Int, completion: @escaping (Result<Recipe, APIError>) -> Void) {
        // Not implemented
    }
    
}
