//
//  Coordinator.swift
//  SpoonRecipeDemo
//
//  Created by Ravit on 27/02/23.
//

import SwiftUI

class Coordinator: ObservableObject {
    @Published var isShowingSplash: Bool = true
    var navigationController: UIViewController?
    
    init(navigationController: UIViewController?) {
        self.navigationController = navigationController
    }
    
    func showRecipeDetailView(for recipe: Recipe) {
        let recipeDetailView = RecipeDetailView(recipe: recipe)
        let viewController = UIHostingController(rootView: recipeDetailView)
        navigationController?.present(viewController, animated: true)
    }
    
    func showSearchView() {
        //let searchView = SearchView(viewModel: SearchViewModel(coordinator: self))
        //let viewController = UIHostingController(rootView: searchView)
        //navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showFavoritesView() {
        let favoritesView = FavoriteRecipesView(viewModel: FavoritesViewModel())
        let viewController = UIHostingController(rootView: favoritesView)
        navigationController?.present(viewController, animated: true)
    }
}
