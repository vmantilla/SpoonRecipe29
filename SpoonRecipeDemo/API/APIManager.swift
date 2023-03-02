//
//  APIManager.swift
//  SpoonRecipeDemo
//
//  Created by Ravit on 27/02/23.
//

import Foundation

protocol APIManagerProtocol {
    func fetchRecipes(endpoint: String, parameters: [String: Any], completion: @escaping (Result<[Recipe], APIError>) -> Void)
    func getRecipe(identifier: Int, completion: @escaping (Result<Recipe, APIError>) -> Void)
}

class APIManager: APIManagerProtocol {
    static let shared = APIManager()

    private let baseURL = "https://api.spoonacular.com"
    private let apiKey = "d518055041dd40d890061b496c1f705a"

    private func url(endpoint: String, parameters: [String: Any]) -> URL {
        var components = URLComponents(string: "\(baseURL)\(endpoint)")!
        components.queryItems = parameters.map { key, value in
            URLQueryItem(name: key, value: "\(value)")
        }
        return components.url!
    }

    func fetchRecipes(endpoint: String, parameters: [String: Any], completion: @escaping (Result<[Recipe], APIError>) -> Void) {
        let keyParameter: [String: Any] = ["apiKey": apiKey]
        let params = keyParameter.merging(parameters) { $1 }

        let url = self.url(endpoint: endpoint, parameters: params)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.networkError(error!)))
                return
            }
            do {
                let decoder = JSONDecoder()
                switch endpoint {
                case Endpoint.randomRecipes :
                    let recipesResponse = try decoder.decode(RecipesResponse.self, from: data)
                    completion(.success(recipesResponse.recipes))
                case Endpoint.searchRecipes:
                    let recipesResponse = try decoder.decode(RecipesSearchResponse.self, from: data)
                    completion(.success(recipesResponse.results))
                default:
                    completion(.failure(.networkError(error!)))
                }
            } catch {
                completion(.failure(.networkError(error)))
            }
        }.resume()
    }

    func getRecipe(identifier: Int, completion: @escaping (Result<Recipe, APIError>) -> Void) {
        let endpoint = "/recipes/\(identifier)/information"
        let parameters: [String: Any] = ["apiKey": apiKey]
        let url = self.url(endpoint: endpoint, parameters: parameters)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.networkError(error!)))
                return
            }

            do {
                let decoder = JSONDecoder()
                let recipe = try decoder.decode(Recipe.self, from: data)
                completion(.success(recipe))
            } catch {
                completion(.failure(.networkError(error)))
            }
        }.resume()
    }
}

enum APIError: Error {
    case networkError(Error)
    case serverError(message: String)
}

enum Endpoint {
    static let randomRecipes = "/recipes/random"
    static let searchRecipes = "/recipes/complexSearch"
}

struct RecipesSearchResponse: Decodable {
    let offset: Int
    let number: Int
    let results: [Recipe]
    let totalResults: Int
}

struct RecipesResponse: Decodable {
    let recipes: [Recipe]
}
