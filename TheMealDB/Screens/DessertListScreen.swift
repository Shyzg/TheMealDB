//
//  DesertListScreen.swift
//  TheMealDB
//
//  Created by Shyzago on 23/08/23.
//

import SwiftUI

/// Sets up the initial screen for displaying the dessert recipe list, instantiates the necessary view model, and triggers the asynchronous population of dessert categories when the view appears
struct DessertListScreen: View {
    @StateObject var viewModel = DessertListViewModel()

    var body: some View {
        NavigationView {
            DessertListView(viewModel: viewModel)
                .task {
                    await viewModel.populateCategories()
                }
        }
    }
}

struct DessertListScreen_Previews: PreviewProvider {
    static var previews: some View {
        DessertListScreen()
    }
}
