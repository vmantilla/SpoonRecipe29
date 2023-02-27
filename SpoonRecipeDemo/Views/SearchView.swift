//
//  SearchView.swift
//  SpoonRecipeSwiftui
//
//  Created by RAVIT SAS on 27/02/23.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var coordinator: Coordinator
    @ObservedObject var viewModel: SearchViewModel
    @State private var showError = false
    
    var body: some View {
        VStack {
            searchField
            
            if viewModel.isLoading {
                ProgressView()
                    .padding()
            } else if !viewModel.errorMessage.isEmpty {
                HStack {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.white)
                    Button(action: {
                        self.viewModel.errorMessage = ""
                        self.showError = false
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                    .padding(.leading, 8)
                }
                .padding()
                .background(Color.red)
                .cornerRadius(8)
                .padding()
                .onAppear {
                    self.showError = true
                }
            }
            
            List(viewModel.recipes) { recipe in
                Button(action: {
                    self.coordinator.showRecipeDetailView(for: recipe)
                }) {
                    RecipeRowView(recipe: recipe)
                }
            }
        }
        .navigationTitle("Search")
    }
    
    var clearButton: some View {
        Button(action: {
            self.viewModel.keyword = ""
        }) {
            Image(systemName: "xmark.circle.fill")
                .foregroundColor(.secondary)
        }
    }

    var searchField: some View {
        HStack {
            TextField("Search", text: $viewModel.keyword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.leading, 10)
                .overlay(clearButton, alignment: .trailing)
            Button(action: {
                self.viewModel.searchRecipes()
            }) {
                Image(systemName: "magnifyingglass")
            }
            .frame(maxWidth: 30)
            .padding(.trailing, 10)
        }
    }
}
