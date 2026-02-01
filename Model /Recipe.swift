//
//  Recipe.swift
//  ReciMe
//
//  Created by Kadir Yildiz on 31/1/2026.
//

import Foundation

struct Ingredient: Codable, Hashable {
    let name: String
    let quantity: Double
    let unit: String
}

struct Recipe: Identifiable, Codable, Hashable {
    let id: UUID
    let title: String
    let description: String
    let image: String
    let servings: Int
    let ingredients: [Ingredient]
    let instructions: [String]
    let diet: String
}

