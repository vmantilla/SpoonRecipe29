//
//  FavoriteRecipe+CoreDataProperties.swift
//  
//
//  Created by RAVIT SAS on 1/03/23.
//
//

import Foundation
import CoreData


extension FavoriteRecipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteRecipe> {
        return NSFetchRequest<FavoriteRecipe>(entityName: "FavoriteRecipe")
    }

    @NSManaged public var id: String?
    @NSManaged public var image: String?
    @NSManaged public var title: String?

}
