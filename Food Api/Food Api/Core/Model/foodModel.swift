//
//  foodModel.swift
//  NetworkingApp
//
//  Created by zayn on 10/05/25.
//

import Foundation

// Top-level response structure
struct Foods: Codable, Identifiable {
    let id = UUID()
    let totalHits: Int
    let foods: [Food]
    
    enum CodingKeys: String, CodingKey {
        case totalHits
        case foods
    }
}

// Food structure 
struct Food: Identifiable, Codable {
    let id: Int
    let name: String
    let foodNutrients: [FoodNutrient]
    
    enum CodingKeys: String, CodingKey {
        case id = "fdcId"
        case name = "description"
        case foodNutrients
    }
}

// FoodNutrient simplified 
struct FoodNutrient: Identifiable, Codable {
    let id = UUID()
    let name: String
    let amount: Double
    
    enum CodingKeys: String, CodingKey {
        case name = "nutrientName"
        case amount = "value"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        amount = try container.decode(Double.self, forKey: .amount)
    }
}
