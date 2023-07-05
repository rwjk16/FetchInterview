//
//  MealDetailViewModel.swift
//  FetchInterview
//
//  Created by Russell Weber on 2023-07-01.
//

import Foundation
import Combine

/// `MealDetailViewModel` is a ViewModel responsible for fetching and storing details of a specific meal.
///
/// uses the Combine framework to handle asynchronous updates and manage subscriptions.
/// It is marked with the `@MainActor` attribute to ensure that all updates to its `@Published` properties happen on the main queue,
/// which is necessary because these properties are bound to the UI.

@MainActor
class MealDetailViewModel: ObservableObject {
    @Published var mealDetail: MealDetail?
    @Published var title: String
    @Published var error: NetworkError?
    @Published var isLoading: Bool = false
    
    internal var cancellables = Set<AnyCancellable>()
    
    let meals: [Meal]
    
    /// Starts listening to changes in `title`, which represents the current meal we are viewing, and fetches meal details whenever it changes.
    /// - Parameters:
    ///   - meals: The list of meals.
    ///   - title: The title of the meal.
    init(meals: [Meal], title: String) {
        self.meals = meals
        self.title = title
        
        $title.sink { [weak self] m in
            if let meal = meals.first(where: { $0.strMeal == m }) {
                self?.fetchMealDetail(for: meal)
            } else {
                self?.error = .invalidData
            }
        }
        .store(in: &cancellables)
    }
    
    /// Fetches the details for a specific meal.
    ///
    /// Handles errors by assigning them to the `error` property.
    /// - Parameter meal: The meal to fetch details for.
    func fetchMealDetail(for meal: Meal) {
        isLoading = true
        error = nil
        
        Task.init { [weak self] in
            do {
                let mealDetail = try await APIService.shared.fetchMealDetail(for: meal.idMeal)
                self?.mealDetail = mealDetail
                self?.isLoading = false
            } catch let error as NetworkError {
                self?.error = error
                self?.isLoading = false
            } catch {
                self?.error = .invalidData
                self?.isLoading = false
            }
        }
    }
    
    /// Cancels all active subscriptions.
    ///
    /// This should be called when the ViewModel is no longer needed, to avoid memory leaks.
    func cancel() {
        cancellables.forEach({ $0.cancel() })
    }
}
