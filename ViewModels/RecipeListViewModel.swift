//
//  RecipeListViewModel.swift
//  ReciMe
//
//  Created by Kadir Yildiz on 31/1/2026.
//

import SwiftUI
import Foundation
import Combine

final class RecipeListViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var searchText: String = ""
    @Published var servingsFilter: Int?
    @Published var includeIngredients: [String] = []
    @Published var excludeIngredients: [String] = []
    @Published var selectedDiet: String? = nil
    
    private let service: RecipeServicing
    
    init(service: RecipeServicing = RecipeService()) {
        self.service = service
        loadRecipes()
    }
    
    func loadRecipes() {
        do {
            recipes = try service.fetchRecipes()
        } catch {
            print("Error loading recipes: \(error)")
        }
    }
    
    var filteredRecipes: [Recipe] {
        recipes.filter { recipe in
            
            let diet = recipe.diet.lowercased()
            let title = recipe.title.lowercased()
            let ingredients = recipe.ingredients.map { $0.name.lowercased() }
            
            // MARK: - Diet filter
            if let selectedDiet, !selectedDiet.isEmpty {
                if diet != selectedDiet.lowercased() {
                    return false
                }
            }
            
            // MARK: - Servings filter 
            if let minServings = servingsFilter {
                if recipe.servings < minServings {
                    return false
                }
            }
            
            // MARK: - Include ingredients
            if !includeIngredients.isEmpty {
                let required = includeIngredients.map { $0.lowercased() }
                if !required.allSatisfy(ingredients.contains) {
                    return false
                }
            }
            
            // MARK: - Exclude ingredients
            if !excludeIngredients.isEmpty {
                let excluded = excludeIngredients.map { $0.lowercased() }
                if excluded.contains(where: ingredients.contains) {
                    return false
                }
            }
            
            // MARK: - Search text (title, diet, ingredients, servings)
            if !searchText.isEmpty {
                let text = searchText.lowercased()
                
                let matchesText =
                title.contains(text) ||
                diet.contains(text) ||
                ingredients.contains(where: { $0.contains(text) })
                
                let matchesServings =
                Int(text).map { recipe.servings == $0 } ?? false
                
                if !(matchesText || matchesServings) {
                    return false
                }
            }
            
            return true
        }
    }
}
