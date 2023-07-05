//
//  MealRow.swift
//  FetchInterview
//
//  Created by Russell Weber on 2023-06-29.
//

import SwiftUI

/// `MealRow` is a `View` that represents a single row in the list of meals.
///
/// It consists of an image of the meal and the name of the meal.
struct MealRow: View {
    
    /// The meal data to be displayed in the row.
    let meal: Meal
    
    var body: some View {
        HStack {
            // Load meal's image using `CachedImageView`. If the image isn't yet loaded,
            // a `ProgressView` is displayed.
            CachedImageView(url: meal.strMealThumb,
                            placeholder: ProgressView())
                // Adjust the image to fit within a square shape.
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            // Display the name of the meal.
            Text(meal.strMeal)
                .font(.headline)
                .foregroundColor(.primary)
        }
        .padding(.vertical, 8)
    }
}
