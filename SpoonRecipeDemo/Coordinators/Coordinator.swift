//
//  Coordinator.swift
//  SpoonRecipeDemo
//
//  Created by Ravit on 27/02/23.
//

import SwiftUI

class Coordinator: ObservableObject {
    @Published var isShowingSplash: Bool = true
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        let splashView = SplashView()
        let viewController = UIHostingController(rootView: splashView)
        navigationController?.pushViewController(viewController, animated: false)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.isShowingSplash = false
            let contentView = MainView()
            let viewController = UIHostingController(rootView: contentView)
            self.navigationController?.pushViewController(viewController, animated: false)
        }
    }
    
    func showRecipeDetailView(for recipe: Recipe) {
        //let recipeDetailView = RecipeView(recipe: recipe, viewModel: RecipeDetailViewModel(recipe: recipe, coordinator: self))
        //let viewController = UIHostingController(rootView: recipeDetailView)
        //navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showSearchView() {
        //let searchView = SearchView(viewModel: SearchViewModel(coordinator: self))
        //let viewController = UIHostingController(rootView: searchView)
        //navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showFavoritesView() {
        let favoritesView = FavoriteRecipesView(viewModel: FavoritesViewModel())
        let viewController = UIHostingController(rootView: favoritesView)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
