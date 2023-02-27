//
//  PersistenceManager.swift
//  SpoonRecipeDemo
//
//  Created by Ravit on 27/02/23.
//

import Foundation
import CoreData

class PersistenceManager {
    
    static let shared = PersistenceManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavoriteRecipe")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveRecipe(_ recipe: Recipe) {
        let context = persistentContainer.viewContext
        let favoriteRecipe = FavoriteRecipe(context: context)
        favoriteRecipe.id = Int32(recipe.id)
        favoriteRecipe.title = recipe.title
        favoriteRecipe.imageURL = recipe.imageURL?.absoluteString
        favoriteRecipe.summary = recipe.summary
        saveContext()
    }
    
    func removeFavoriteRecipe(_ recipe: Recipe) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", recipe.id)
        let favoriteRecipes = try? context.fetch(fetchRequest)
        favoriteRecipes?.forEach { context.delete($0) }
        
        saveContext()
    }
    
    func fetchFavoriteRecipes() -> [Recipe] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        let favoriteRecipes = try? context.fetch(fetchRequest)
        return favoriteRecipes?.map { Recipe(id: Int($0.id),
                                             title: $0.title ?? "", summary: $0.summary ?? "", imageURL: URL(string: $0.imageURL ?? "")) } ?? []
    }
}
