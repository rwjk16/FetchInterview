//
//  MealDetailContent.swift
//  FetchInterview
//
//  Created by Russell Weber on 2023-07-04.
//

import SwiftUI

/// `MealDetailContent` is a SwiftUI View that displays the details of a specific meal.
///
/// It includes an image of the meal, its ingredients, and instructions on how to prepare it.
struct MealDetailContent: View {
    let mealDetail: MealDetail
    
    var body: some View {
        VStack(alignment: .leading) {
            // A large image of the meal.
            CachedImageView(url: mealDetail.strMealThumb,
                            placeholder: ProgressView())
            .scaledToFit()
            .cornerRadius(10)
            .padding(.bottom)
            // Meal's name as a stylized header.
            Text(mealDetail.strMeal)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom)
            // Ingredients section.
            VStack(alignment: .leading) {
                Text("Ingredients")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.bottom)
                ForEach(mealDetail.ingredientMeasurements, id: \.self) {
                    BulletListItemView(text: $0)
                }
            }
            .padding(.bottom)
            // Separator
            Divider()
                .padding(.vertical)
            // Instructions section.
            VStack(alignment: .leading) {
                Text("Instructions")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.bottom)
                Text(mealDetail.strInstructions)
                    .font(.body)
                    .padding(.bottom, 1)
            }
        }
        .padding()
    }
}
