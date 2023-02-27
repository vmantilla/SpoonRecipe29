//
//  Instructions.swift
//  spoonacular
//
//  Created by Ravit on 27/02/23.
//

import Foundation

struct Instruction: Decodable {
    let name: String
    let steps: [Step]
}

struct Step: Decodable {
    let number: Int
    let step: String
    let ingredients: [Ingredient]
    let equipment: [Equipment]
    let length: Length?
}

struct Ingredient: Decodable {
    let id: Int
    let name: String
    let localizedName: String
    let image: String
}

struct Equipment: Decodable {
    let id: Int
    let name: String
    let localizedName: String
    let image: String
}

struct Length: Decodable {
    let number: Int
    let unit: String
}
