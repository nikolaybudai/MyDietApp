//
//  ViewController.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 28/03/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var endpoint = RecipesEndpoint()
        let cuisine = URLQueryItem(name: "cuisineType", value: "Italian")
        let diet = URLQueryItem(name: "diet", value: "balanced")
        endpoint.queryItems?.append(cuisine)
        endpoint.queryItems?.append(diet)
        
        let service: RecipesServiceProtocol = RecipesService()
        Task {
            let result = await service.getRecipes(with: endpoint)
            switch result {
            case .success(let response):
                print(response.hits.first?.recipe.cuisineType ?? "no cuisine")
            case .failure(let failure):
                print(String(describing: failure))
                print("error")
            }
        }
        
        
        let label = UILabel()
        label.text = "Test text"
        
        label.font = .Roboto.bold.size(of: 40)
        label.textColor = AppColors.highlightYellow
        
        view.addView(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        view.backgroundColor = .white
    }


}

