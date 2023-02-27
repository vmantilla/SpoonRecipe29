//
//  Nutrition.swift
//  spoonacular
//
//  Created by Ravit on 27/02/23.
//

import Foundation

struct Nutrition: Codable {
    let nutrients: [Nutrient]
}

struct Nutrient: Codable {
    let name: String
    let amount: Double
    let unit: String
}
