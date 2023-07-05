//
//  APIService.swift
//  FetchInterview
//
//  Created by Russell Weber on 2023-06-29.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case networkProblem
    case decodingError
    case noData
    case invalidData
    
    var description: String {
        switch self {
        case .badURL:
            return "Unable to reach TheMealDB"
        case .networkProblem:
            return "Network is unreachable"
        case .decodingError:
            return "The data recieved is in an unexpected format"
        case .noData:
            return "There was no data returned"
        case .invalidData:
            return "The data returned was invalid"
        }
    }
}

// A singleton service for API calls.
/// All methods inside this class should use Swift 5.5 async/await and throw `NetworkError` for any error that arises.
class APIService {
    /// Shared instance to allow for singleton pattern
    static let shared = APIService()
    
    /// Asynchronously fetches a list of meals for a given category from the server.
    /// - Parameter category: The category of meals to fetch.
    /// - Throws: `NetworkError` if any network, decoding or data errors occur.
    /// - Returns: An array of `Meal` objects if the request succeeds.
    func fetchMeals(for category: String) async throws -> [Meal] {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=\(category)") else {
            throw NetworkError.badURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            let httpResponse = response as? HTTPURLResponse
            guard httpResponse?.statusCode == 200 else {
                throw NetworkError.networkProblem
            }
            
            let mealResponse = try JSONDecoder().decode(MealResponse.self, from: data)
            let meals = mealResponse.meals.sorted { $0.strMeal < $1.strMeal }
            return meals
        } catch is DecodingError {
            throw NetworkError.decodingError
        } catch {
            throw NetworkError.networkProblem
        }
    }
    
    /// Asynchronously fetches the detail of a meal from the server.
        /// - Parameter mealID: The id of the meal.
        /// - Throws: `NetworkError` if any network, decoding or data errors occur.
        /// - Returns: A `MealDetail` object if the request succeeds.
    func fetchMealDetail(for mealID: String) async throws -> MealDetail {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)") else {
            throw NetworkError.badURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            let httpResponse = response as? HTTPURLResponse
            guard httpResponse?.statusCode == 200 else {
                throw NetworkError.networkProblem
            }
            
            let mealDetailResponse = try JSONDecoder().decode(MealDetailResponse.self, from: data)
            
            guard let mealDetail = mealDetailResponse.meals.first else {
                throw NetworkError.invalidData
            }
            
            return mealDetail
        } catch is DecodingError {
            throw NetworkError.decodingError
        } catch {
            throw NetworkError.networkProblem
        }
    }
    
    /// Asynchronously fetches a list of meal categories from the server.
        /// - Throws: `NetworkError` if any network, decoding or data errors occur.
        /// - Returns: An array of `MealCategory` objects if the request succeeds.
    func fetchCategories() async throws -> [MealCategory] {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/categories.php") else {
            throw NetworkError.badURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            let httpResponse = response as? HTTPURLResponse
            guard httpResponse?.statusCode == 200 else {
                throw NetworkError.networkProblem
            }
            
            let mealCategoryResponse = try JSONDecoder().decode(MealCategoryResponse.self, from: data)
            let categories = mealCategoryResponse.categories.sorted { $0.strCategory < $1.strCategory }
            return categories
        } catch is DecodingError {
            throw NetworkError.decodingError
        } catch {
            throw NetworkError.networkProblem
        }
    }
}
