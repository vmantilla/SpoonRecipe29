//
//  Nutrient.swift
//  spoonacular
//
//  Created by Ravit on 27/02/23.
//

import Foundation

struct Nutrient: Decodable {
    let name: String
    let amount: Double
    let unit: String
}
