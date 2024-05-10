//
//  MockRecipesService.swift
//  MyDietAppTests
//
//  Created by Nikolay Budai on 10/05/24.
//

import Foundation
@testable import MyDietApp

class RecipesServiceMock: RecipesServiceProtocol {
    
    var shouldReturnError = false
    var numberOfItems = 0
    var fetchedMoreNumber = 0
    
    func getRecipes(with endpoint: Endpoint) async -> Result<RecipesResponse, RequestError> {
        if !shouldReturnError {
            numberOfItems = 5
            fetchedMoreNumber = 10
            return .success(RecipesResponse(from: 0, to: 1, count: numberOfItems, links: ResponseLinks(next: Next(href: "")), hits: []))
        } else {
            return .failure(.unknown)
        }
    }
}
