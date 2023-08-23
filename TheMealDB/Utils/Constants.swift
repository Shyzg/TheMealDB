//
//  Constants.swift
//  TheMealDB
//
//  Created by Shyzago on 23/08/23.
//

import Foundation

struct Constants {
    struct Urls {
        ///  URL of list of desserts
        static let dessertListUrl = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Seafood")!
        
        /// Base URL of specific dessert details
        static let baseUrl = "https://www.themealdb.com/api/json/v1/1/"
        
        /// Returns the URL for retrieving recipe details for a specific meal.
        static func recipeDetailsUrl(for mealId: String) -> URL {
            let urlString = "\(baseUrl)lookup.php?i=\(mealId)"
            return URL(string: urlString)!
        }
    }
}
