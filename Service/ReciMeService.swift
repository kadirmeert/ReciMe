//
//  ReciMeService.swift
//  ReciMe
//
//  Created by Kadir Yildiz on 31/1/2026.
//

import Foundation

protocol RecipeServicing {
    func fetchRecipes() throws -> [Recipe]
}

final class RecipeService: RecipeServicing {
    func fetchRecipes() throws -> [Recipe] {
        guard let url = Bundle.main.url(forResource: "recipes", withExtension: "json") else {
            throw URLError(.fileDoesNotExist)
        }

        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([Recipe].self, from: data)
    }
}
