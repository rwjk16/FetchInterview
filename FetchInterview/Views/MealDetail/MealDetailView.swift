//
//  MealDetailView.swift
//  FetchInterview
//
//  Created by Russell Weber on 2023-06-29.
//

import SwiftUI

/// `MealDetailView` is a SwiftUI View that shows the detailed information of a specific meal.
///
/// It uses the `MealDetailViewModel` to fetch and store the details of the meal.
/// This view provides a user interface that includes a list of ingredients, instructions, and a toolbar.

struct MealDetailView: View {
    @ObservedObject var viewModel: MealDetailViewModel
    let meal: Meal
    private let imageCache = ImageCache.shared
    
    var body: some View {
        ScrollView {
            Group {
                if let mealDetail = viewModel.mealDetail,
                   !viewModel.isLoading {
                    MealDetailContent(mealDetail: mealDetail)
                } else {
                    LoadingView()
                        .frame(maxWidth: .infinity,
                               maxHeight: .infinity)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                NavigationBarView(category: $viewModel.title,
                                  categories: viewModel.meals.map({ $0.strMeal }),
                                  isLoading: viewModel.isLoading,
                                  error: viewModel.error) {
                    viewModel.fetchMealDetail(for: meal)
                }
            }
        }
        .onAppear {
            viewModel.fetchMealDetail(for: meal)
        }
        .onDisappear {
            viewModel.cancel()
        }
    }
}

struct MealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = MealDetailViewModel(meals: [Meal(idMeal: "53049",
                                                  strMeal: "Apam balik",
                                                  strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg"),
                                             Meal(idMeal: "53049",
                                                        strMeal: "Apam balik",
                                                        strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg"),
                                             Meal(idMeal: "53049",
                                                        strMeal: "Apam balik",
                                                        strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")],
                                     title: "Apam balik")
        MealDetailView(viewModel: vm,
                       meal: Meal(idMeal: "53049",
                                  strMeal: "Apam balik",
                                  strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg"))
    }
}
