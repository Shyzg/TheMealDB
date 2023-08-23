//
//  DesertListResponse.swift
//  TheMealDB
//
//  Created by Shyzago on 23/08/23.
//

import Foundation

/// Represents the response structure for the dessert list API.
struct DessertListResponse: Decodable {
    /// An optional array of meals (desserts).
    var meals: [Meal]?
}

/// Represents a meal (dessert) item.
struct Meal: Decodable, Identifiable {
    /// The unique identifier for the meal.
    let idMeal: String
    
    /// The name of the meall
    let strMeal: String
    
    /// The URL string for the thumbnail image of the meal.
    let strMealThumb: String
    
    /// Computed property for the identifier, conforming to the Identifiable protocol
    var id: String { idMeal }
}
