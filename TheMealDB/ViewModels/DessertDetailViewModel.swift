//
//  DessertDetailViewModel.swift
//  TheMealDB
//
//  Created by Shyzago on 23/08/23.
//

import Foundation

class DessertDetailViewModel: ObservableObject {
    @Published var recipeDetail: RecipeDetail?
    @Published var error: Error?
    
    /// Represents an ingredient and its corresponding measurement.
    struct IngredientMeasurement: Identifiable {
        let id = UUID()
        let ingredient: String
        let measurement: String
    }
    
    internal let dessertId: String
    
    /// Initializes the view model with a dessert ID
    init(dessertId: String = "") {
        self.dessertId = dessertId
    }
    
    /// Fetches the recipe details from the API using web service
    func fetchRecipeDetails(using webservice: Webservice = Webservice()) async {
        let url = Constants.Urls.recipeDetailsUrl(for: dessertId)
        
        do {
            self.recipeDetail = try await webservice.get(url: url, parse: { data in
                let decoder = JSONDecoder()
                let response = try decoder.decode(DessertDetailResponse.self, from: data)
                return response.meals?.first
            })
            print("Recipe details fetched successfully")
            
        } catch {
            self.error = error
            print("Failed to fetch recipe details: \(error)")
            
        }
    }
}
