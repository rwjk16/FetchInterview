//
//  DataModels.swift
//  FetchInterview
//
//  Created by Russell Weber on 2023-06-29.
//

import Foundation

/// `Meal` data model representing a single meal item.
///
/// This struct includes meal's ID, name, and thumbnail URL.
struct Meal: Codable, Identifiable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    
    /// Identifier for `Identifiable` protocol.
    var id: String { idMeal }
}

/// `MealResponse` data model used to decode the list of meals from API response.
struct MealResponse: Codable {
    let meals: [Meal]
}

/// `MealDetail` data model representing detailed information about a meal.
///
/// This struct includes meal's ID, name, instructions, thumbnail URL, ingredients, and measurements.
struct MealDetail: Codable {
    let idMeal: String
    let strMeal: String
    let strInstructions: String
    let strMealThumb: String
    var ingredients: [String] = []
    var measurements: [String] = []
    let ingredientMeasurements: [String]
    
    enum CodingKeys: String, CodingKey {
        case idMeal, strMeal, strInstructions, strMealThumb
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10, strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15, strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10, strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15, strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)
        strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
        
        let ingredientKeys = (1...20).map { CodingKeys(rawValue: "strIngredient\($0)") }
        ingredients = ingredientKeys.compactMap { try? container.decodeIfPresent(String.self, forKey: $0!) }.filter({ !$0.isEmpty })
        
        let measurementKeys = (1...20).map { CodingKeys(rawValue: "strMeasure\($0)") }
        measurements = measurementKeys.compactMap { try? container.decodeIfPresent(String.self, forKey: $0!) }.filter({ $0 != " " })
        
        ingredientMeasurements = zip(ingredients, measurements).map { "\($0) - \($1)" }
    }

    func encode(to encoder: Encoder) throws { }
}

/// `MealCategory` data model representing a category of meals.
///
/// This struct includes category's ID, name, thumbnail URL, and description.
struct MealCategory: Codable {
    let idCategory: String
    let strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
}

/// `MealCategoryResponse` data model used to decode the list of meal categories from API response.
struct MealCategoryResponse: Codable {
    let categories: [MealCategory]
}

/// `MealDetailResponse` data model used to decode the detailed information about a meal from API response.
struct MealDetailResponse: Codable {
    let meals: [MealDetail]
}
