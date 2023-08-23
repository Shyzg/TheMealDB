//
//  DessertListViewModel.swift
//  TheMealDB
//
//  Created by Shyzago on 23/08/23.
//

import Foundation

@MainActor
class DessertListViewModel: ObservableObject {
    @Published var recipes: [Meal] = []
    var dessertDetailViewModel: DessertDetailViewModel
    var webservice: Webservice
    
    @Published var selectedDessert: Meal?
    
    init(webservice: Webservice = Webservice()) {
        self.webservice = webservice
        dessertDetailViewModel = DessertDetailViewModel(dessertId: "")
    }
    
    // fetches list of desserts from API using a webservice
    func populateCategories(using webservice: Webservice? = nil) async {
        let webServiceToUse = webservice ?? self.webservice
        
        do {
            let dessertListResponse = try await webServiceToUse.get(url: Constants.Urls.dessertListUrl) { data in
                return try? JSONDecoder().decode(DessertListResponse.self, from: data)
            }
            // updating recipes property with received dessert list
            if let dessertList = dessertListResponse.meals {
                self.recipes = dessertList
            } else {
                // Handle the case when meals is nil
                self.recipes = []
            }
        } catch {
            print(error)
        }
    }
    
    // creates instance of DessertDetailViewModel using the selected dessert ID
    func selectDessert(_ dessert: Meal) {
        selectedDessert = dessert
        dessertDetailViewModel = DessertDetailViewModel(dessertId: dessert.idMeal)
    }
}
