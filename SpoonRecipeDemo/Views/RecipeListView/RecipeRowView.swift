//
//  RecipeRowView.swift
//  SpoonRecipeDemo
//
//  Created by Ravit on 27/02/23.
//

import Foundation
import SwiftUI

struct RecipeRowView: View {
    var recipe: Recipe
    
    var body: some View {
        HStack(alignment: .center) {
            if let imageURL = URL(string: recipe.image ?? "") {
                AsyncImage(url: imageURL) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            case .empty:
                                Image(systemName: "photo")
                            case .failure:
                                Image(systemName: "exclamationmark.icloud")
                            @unknown default:
                                EmptyView()
                            }
                    }
                    .scaledToFill()
                    .frame(width: 120, height: 80)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: 120, height: 80)
            }
            Spacer()
            VStack(alignment: .leading) {
                Text(recipe.title)
                    .font(.headline)
                Text(recipe.summary ?? "")
                    .font(.subheadline)
                    .lineLimit(2)
            }
        }
        .padding(.vertical, 8)
    }
}
