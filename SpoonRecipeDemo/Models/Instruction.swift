//
//  Instructions.swift
//  spoonacular
//
//  Created by Ravit on 27/02/23.
//

import Foundation

struct Ingredient: Codable {
    let id: Int?
    let name: String
}

struct Instruction: Codable {
    let id: Int?
    let name: String
    let steps: [Step]
}

struct Step: Codable {
    let number: Int
    let step: String
}

