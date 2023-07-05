//
//  MealListView.swift
//  FetchInterview
//
//  Created by Russell Weber on 2023-07-01.
//

import SwiftUI

/// Primary view representing a list of meals.
///
/// A list of meals are shown in this view, each represented by a `MealRow`. The meal data is fetched by the
/// associated `MealListViewModel` when this view appears, and any errors or loading state are handled appropriately.
struct MealListView: View {
    
    @ObservedObject var viewModel: MealListViewModel

    var body: some View {
        NavigationView {
            ZStack {
                if let error = viewModel.error {
                    ErrorView(error: error) {
                        viewModel.fetchMeals()
                    }
                } else {
                    List {
                        ForEach(viewModel.meals) { meal in
                            let detailVM = MealDetailViewModel(meals: viewModel.meals, title: meal.strMeal)
                            NavigationLink(destination: MealDetailView(viewModel: detailVM, meal: meal)) {
                                MealRow(meal: meal)
                            }
                        }
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            NavigationBarView(category: $viewModel.category,
                                              categories: viewModel.categories,
                                              isLoading: viewModel.isLoading,
                                              error: viewModel.error) {
                                viewModel.fetchMealCategories()
                            }
                        }
                    }
                    if viewModel.isLoading {
                        LoadingView()
                            .frame(maxWidth: .infinity,
                                   maxHeight: .infinity)
                    }
                }
            }
        }
        .onAppear {
            if viewModel.categories.isEmpty {
                viewModel.fetchMealCategories()
            }
            if viewModel.meals.isEmpty {
                viewModel.fetchMeals()
            }
        }
    }
}

/// Preview Provider for the `MealListView`.
///
/// The ViewModel is initialized with some sample data and used to create a `MealListView` for previewing in the canvas.
struct MealListView_Preview: PreviewProvider {
    static var previews: some View {
        let vm = MealListViewModel(category: "Dessert", categories: ["Dessert"])
        MealListView(viewModel: vm)
    }
}
