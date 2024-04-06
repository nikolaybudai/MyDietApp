//
//  RecipiesService.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 05/04/24.
//

import Foundation

protocol RecipesServiceProtocol {
    func getRecipes(with endpoint: Endpoint) async -> Result<RecipesResponse, RequestError>
}

struct RecipesService: NetworkClient, RecipesServiceProtocol {
    func getRecipes(with endpoint: Endpoint) async -> Result<RecipesResponse, RequestError> {
        return await sendRequest(endpoint: endpoint, responseModel: RecipesResponse.self)
    }
}
