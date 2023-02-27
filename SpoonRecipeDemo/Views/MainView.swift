//
//  MainView.swift
//  SpoonRecipeDemo
//
//  Created by RAVIT SAS on 27/02/23.
//

import Foundation
import SwiftUI

struct MainView: View {
    @StateObject var recipeViewModel = RecipeViewModel()
    @StateObject var searchViewModel = SearchViewModel()
    @StateObject var favoritesViewModel = FavoritesViewModel()
    
    @StateObject var coordinator = Coordinator(navigationController: UINavigationController())

    var body: some View {
        TabView {
            RecipeListView(viewModel: recipeViewModel)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Recipes")
                }
            SearchView(viewModel: searchViewModel)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            FavoriteRecipesView(viewModel: favoritesViewModel)
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favorites")
                }
        }
        .environmentObject(coordinator)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
    
}
