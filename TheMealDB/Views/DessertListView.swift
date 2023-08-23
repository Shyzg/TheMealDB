//
//  DessertListView.swift
//  TheMealDB
//
//  Created by Shyzago on 23/08/23.
//

import SwiftUI

struct DessertListView: View {
    @ObservedObject var viewModel: DessertListViewModel
    let indexLetters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ") // Letters for index list

    /// A computed property that returns the recipes sorted alphabetically by dessert name.
    var sortedRecipes: [Meal] {
        return viewModel.recipes.sorted { $0.strMeal < $1.strMeal }
    }

    var body: some View {
        NavigationView {
            ScrollViewReader { scrollViewProxy in
                List {
                    ///The dessert recipes are iterated using a ForEach loop, and if the recipe's dessert name starts with the current letter, a NavigationLink is created. Tapping on a recipe will navigate to the DessertDetailView passing the dessert ID
                    ForEach(indexLetters, id: \.self) { letter in
                        Section(header: Text(String(letter))) {
                            ForEach(sortedRecipes, id: \.idMeal) { recipe in
                                if recipe.strMeal.starts(with: String(letter)) {
                                    NavigationLink(destination: DessertDetailView(dessertId: recipe.idMeal)) {
                                        Text(recipe.strMeal.capitalized)
                                    }
                                }
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .navigationBarHidden(true)
                .onAppear {
                    Task {
                        await viewModel.populateCategories()
                    }
                }
            }
            .navigationBarTitle("Seafood Recipes", displayMode: .inline)
        }
    }
}
