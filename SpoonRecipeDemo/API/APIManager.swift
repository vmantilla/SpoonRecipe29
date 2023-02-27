//
//  APIManager.swift
//  SpoonRecipeDemo
//
//  Created by Ravit on 27/02/23.
//

import Foundation
import Combine

class APIManager {
    static let shared = APIManager()
    
    private let baseURL = "https://api.spoonacular.com"
    private let apiKey = "b10544a5bea14545a2eea74f84bc977a"
    private let session: URLSession
    
    private init() {
        self.session = URLSession(configuration: .default)
    }
    
    func getRecipes(completion: @escaping (Result<[Recipe], APIError>) -> Void) {
        let endpoint = "/recipes/random"
        let parameters: [String: Any] = [
            "number": 20,
            "apiKey": apiKey
        ]
        let url = buildURL(endpoint: endpoint, parameters: parameters)
        let request = URLRequest(url: url)
        session.dataTask(with: request) { data, response, error in
            if let data = data, let recipesResponse = try? JSONDecoder().decode(RecipesResponse.self, from: data) {
                completion(.success(recipesResponse.recipes))
            } else if let error = error {
                completion(.failure(.networkError(error)))
            } else {
                completion(.failure(.unknownError))
            }
        }.resume()
    }
    
    func searchRecipes(keyword: String, completion: @escaping (Result<[Recipe], APIError>) -> Void) {
        let endpoint = "/recipes/complexSearch"
        let parameters: [String: Any] = [
                    "query": keyword,
                    "maxFat": 25,
                    "number": 10,
                    "apiKey": apiKey
                ]
        let url = buildURL(endpoint: endpoint, parameters: parameters)
        let request = URLRequest(url: url)
        session.dataTask(with: request) { data, response, error in
            if let data = data, let recipesResponse = try? JSONDecoder().decode(RecipesSearchResponse.self, from: data) {
                completion(.success(recipesResponse.recipes))
            } else if let error = error {
                completion(.failure(.networkError(error)))
            } else {
                completion(.failure(.unknownError))
            }
        }.resume()
    }
    
    private func buildURL(endpoint: String, parameters: [String: Any]) -> URL {
        let queryItems = parameters.map { key, value in
            URLQueryItem(name: key, value: "\(value)")
        }
        var urlComponents = URLComponents(string: baseURL + endpoint)!
        urlComponents.queryItems = queryItems
        return urlComponents.url!
    }
}

enum APIError: Error {
    case networkError(Error)
    case unknownError
}

struct RecipesResponse: Decodable {
    let recipes: [Recipe]
}

struct RecipesSearchResponse: Decodable {
    let recipes: [Recipe]
}
