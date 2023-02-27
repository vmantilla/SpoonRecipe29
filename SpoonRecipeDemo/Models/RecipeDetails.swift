//
//  ReceipeDetails.swift
//  spoonacular
//
//  Created by Ravit on 27/02/23.
//

import Foundation

struct RecipeDetails: Decodable, Equatable {
    let vegetarian: Bool
    let vegan: Bool
    let glutenFree: Bool
    let dairyFree: Bool
    let veryHealthy: Bool
    let cheap: Bool
    let veryPopular: Bool
    let sustainable: Bool
    let lowFodmap: Bool
    let weightWatcherSmartPoints: Int
    let gaps: String
    let preparationMinutes: Int
    let cookingMinutes: Int
    let aggregateLikes: Int
    let healthScore: Int
    let creditsText: String
    let sourceName: String
    let pricePerServing: Double
    let id: Int
    let title: String
    let readyInMinutes: Int
    let servings: Int
    let sourceUrl: String
    let image: String
    let imageType: String
    let summary: String
    let cuisines: [String]
    let dishTypes: [String]
    let diets: [String]
    let occasions: [String]
    let winePairing: WinePairing
    let extendedIngredients: [ExtendedIngredient]
    let instructions: String
    let analyzedInstructions: [Instruction]
    
    static func == (lhs: RecipeDetails, rhs: RecipeDetails) -> Bool {
        return lhs.id == rhs.id
    }
}

struct WinePairing: Decodable {
    let pairedWines: [String]
    let pairingText: String
    let productMatches: [ProductMatch]
}

struct ProductMatch: Decodable {
    let id: Int
    let title: String
    let description: String
    let price: String
    let imageUrl: String
    let averageRating: Double
    let ratingCount: Double
    let score: Double
    let link: String
}
