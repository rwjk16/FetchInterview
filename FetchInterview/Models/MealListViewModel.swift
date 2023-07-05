//
//  MealListViewModel.swift
//  FetchInterview
//
//  Created by Russell Weber on 2023-07-01.
//

import Foundation
import Combine

/// `MealListViewModel` represents a list of meals.
/// It fetches meals from a selected category and updates the list whenever the category changes.
class MealListViewModel: ObservableObject {
    
    @Published var meals: [Meal] = []
    @Published var error: NetworkError? = nil
    @Published var isLoading: Bool = false
    @Published var category: String
    @Published var categories: [String]
    
    private var cancellables = Set<AnyCancellable>()
    
    /// Initializes a new instance with a category and categories.
    /// - Parameters:
    ///   - category: The selected category for which to fetch meals.
    ///   - categories: The list of available categories.
    init(category: String = "Dessert",
         categories: [String] = []) {
        self.category = category
        self.categories = categories
        
        $category
            .sink { [weak self] _ in
                self?.fetchMeals()
            }
            .store(in: &cancellables)
    }
    
    /// Fetches meals for the selected category.
    func fetchMeals() {
        isLoading = true
        error = nil
        
        Task.init { [weak self] in
            do {
                let meals = try await APIService.shared.fetchMeals(for: self?.category ?? "")
                DispatchQueue.main.async { [weak self] in
                    self?.meals = meals
                    self?.isLoading = false
                }
            } catch let networkError as NetworkError {
                DispatchQueue.main.async { [weak self] in
                    self?.error = networkError
                    self?.isLoading = false
                }
            } catch {
                print("Unexpected error: \(error)")
            }
        }
    }
    
    func fetchMealCategories() {
        isLoading = true
        error = nil
        
        Task.init {
            do {
                let categories = try await APIService.shared.fetchCategories()
                DispatchQueue.main.async { [weak self] in
                    self?.categories = categories.map({$0.strCategory})
                    self?.isLoading = false
                }
            } catch let networkError as NetworkError {
                DispatchQueue.main.async { [weak self] in
                    self?.error = networkError
                    self?.isLoading = false
                    print(networkError.description)
                }
            } catch {
                print("Unexpected error: \(error)")
            }
        }
    }
    
    /// Cancels all ongoing tasks when the object is deallocated.
    deinit {
        cancellables.forEach { $0.cancel() }
    }
}
