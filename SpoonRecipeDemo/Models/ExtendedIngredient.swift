//
//  Ingedient.swift
//  spoonacular
//
//  Created by Ravit on 27/02/23.
//

import Foundation

struct ExtendedIngredient: Decodable {
    let id: Int
    let aisle: String
    let image: String
    let consistency: String
    let name: String
    let nameClean: String
    let original: String
    let originalName: String
    let amount: Double
    let unit: String
    let meta: [String]
    let measures: Measure
}

struct Measure: Decodable {
    let us: Unit
    let metric: Unit
}

struct Unit: Decodable {
    let amount: Double
    let unitShort: String
    let unitLong: String
}
