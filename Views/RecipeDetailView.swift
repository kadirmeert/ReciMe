//
//  RecipeDetailView.swift
//  ReciMe
//
//  Created by Kadir Yildiz on 31/1/2026.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe

    @State private var currentServings: Int

    // MARK: - Init
    init(recipe: Recipe) {
        self.recipe = recipe
        _currentServings = State(initialValue: recipe.servings)
    }

    // MARK: - Computed Properties
    private var scaleFactor: Double {
        Double(currentServings) / Double(recipe.servings)
    }

    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(spacing: 4) {

                recipeImage

                descriptionCard

                ingredientsCard

                instructionsCard

                dietCard
            }
            .background(Color(.systemGray6))
        }
        .navigationBarTitle("", displayMode: .inline)
        .background(Color(.systemBackground))
    }
}

// MARK: - Subviews
private extension RecipeDetailView {

    var recipeImage: some View {
        Image(recipe.image)
            .resizable()
            .scaledToFill()
            .frame(height: 200)
            .frame(maxWidth: .infinity)
            .clipped()
    }

    var descriptionCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(recipe.title)
                .font(.headline)

            Text(recipe.description)
                .foregroundStyle(.secondary)

            HStack {
                actionButton(icon: "bookmark.fill", title: "Cookbooks")
                Spacer()
                actionButton(icon: "calendar", title: "Meal Plan")
                Spacer()
                actionButton(icon: "cart.fill", title: "Groceries")
                Spacer()
                actionButton(icon: "square.and.arrow.up", title: "Share")
            }
            .padding(.vertical, 8)
        }
        .cardStyle()
    }

    var ingredientsCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("INGREDIENTS")
                .font(.headline)

            servingsSelector

            ForEach(recipe.ingredients, id: \.self) { ingredient in
                let quantity = ingredient.quantity * scaleFactor
                Text("• \(formatted(quantity)) \(ingredient.unit) \(ingredient.name)")
            }
        }
        .cardStyle()
    }

    var servingsSelector: some View {
        HStack {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(.separator), lineWidth: 1)
                .frame(width: 100, height: 30)
                .overlay(
                    HStack {
                        Button {
                            if currentServings > 1 {
                                currentServings -= 1
                            }
                        } label: {
                            Text("-")
                                .foregroundStyle(.orange)
                        }

                        Spacer()

                        Text("\(currentServings)")
                            .font(.system(size: 14))

                        Spacer()

                        Button {
                            if currentServings < 100 {
                                currentServings += 1
                            }
                        } label: {
                            Text("+")
                                .foregroundStyle(.orange)
                        }
                    }
                    .padding(.horizontal, 6)
                )

            Text("servings")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding(.leading, 8)
        }
    }

    var instructionsCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("INSTRUCTIONS")
                .font(.headline)

            ForEach(Array(recipe.instructions.enumerated()), id: \.offset) { index, step in
                HStack(alignment: .top, spacing: 12) {
                    Circle()
                        .fill(Color.orange.opacity(0.15))
                        .frame(width: 28, height: 28)
                        .overlay(
                            Text("\(index + 1)")
                                .font(.subheadline.weight(.semibold))
                                .foregroundStyle(.orange)
                        )

                    Text(step)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
        .cardStyle()
    }

    var dietCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("DIET")
                .font(.headline)

            Text(recipe.diet)
                .foregroundStyle(.secondary)
        }
        .cardStyle()
    }
}

// MARK: - Helpers
private extension RecipeDetailView {

    func formatted(_ value: Double) -> String {
        value.truncatingRemainder(dividingBy: 1) == 0
        ? String(Int(value))
        : String(format: "%.2f", value)
    }

    func actionButton(
        icon: String,
        title: String,
        action: @escaping () -> Void = {}
    ) -> some View {
        VStack(spacing: 6) {
            Button(action: action) {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.orange)
                    .padding()
                    .background(
                        Circle()
                            .fill(Color(.systemBackground))
                            .overlay(
                                Circle()
                                    .stroke(Color(.separator), lineWidth: 1)
                            )
                    )
            }

            Text(title)
                .font(.footnote)
        }
    }
}

// MARK: - Card Modifier
struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.systemBackground))
    }
}

extension View {
    func cardStyle() -> some View {
        modifier(CardModifier())
    }
}


#Preview {
    let sampleRecipe = Recipe(
        id: UUID(),
        title: "Slow Cooker Lentil Bolognese",
        description: "A quick and healthy vegetarian pasta dish.",
        image: "lentil pasta",
        servings: 2,
        ingredients: [
            Ingredient(name: "Pasta", quantity: 200, unit: "g"),
            Ingredient(name: "Green Lentils", quantity: 1, unit: "cup"),
            Ingredient(name: "Passata", quantity: 1, unit: "cup"),
            Ingredient(name: "Vegetables", quantity: 2, unit: "cup"),
            Ingredient(name: "Walnuts", quantity: 0.5, unit: "cup")
        ],
        instructions: [
            "Peel and grate the carrot. Finely chop the red onion, mushrooms and walnuts.",
            "Add remaining ingredients and mix well.",
            "Cook on high for 4.5 hours.",
            "Serve with spaghetti."
        ],
        diet: "Vegetarian" 
    )
    
    Group {
        NavigationStack {
            RecipeDetailView(recipe: sampleRecipe)
        }
    }
}
