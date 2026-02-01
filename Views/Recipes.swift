//
//  Recipes.swift
//  ReciMe
//
//  Created by Kadir Yildiz on 31/1/2026.
//

import SwiftUI

struct Recipes: View {
    @StateObject private var viewModel = RecipeListViewModel()
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    private let cardHeight: CGFloat = 200
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.filteredRecipes) { recipe in
                        NavigationLink(value: recipe) {
                            RecipeCardView(recipe: recipe, height: cardHeight)
                                .contentShape(Rectangle()) 
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 16)
            }
            .navigationTitle("Recipes")
            .searchable(text: $viewModel.searchText)
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeDetailView(recipe: recipe)
            }
        }
    }
}

// MARK: - Recipe Card Subview
struct RecipeCardView: View {
    let recipe: Recipe
    let height: CGFloat
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Image
            Image(recipe.image)
                .resizable()
                .scaledToFit()
                .frame(height: height)
                .frame(maxWidth: .infinity)
                .clipped()
            
            // Gradient overlay
            LinearGradient(
                colors: [Color.black.opacity(0), Color.black.opacity(0.7)],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: height * 0.4)
            
            // Title
            Text(recipe.title)
                .font(.headline)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 8)
                .padding(.bottom, 12)
                .frame(maxWidth: .infinity)
        }
        .frame(height: height)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.separator), lineWidth: 1)
        )
    }
}

// MARK: - Preview
#Preview {
    Group {
        Recipes()
            .preferredColorScheme(.light)
        Recipes()
            .preferredColorScheme(.dark)
    }
}
