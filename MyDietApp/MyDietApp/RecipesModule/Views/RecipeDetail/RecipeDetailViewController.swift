//
//  RecipeDetailViewController.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 18/04/24.
//

import UIKit

final class RecipeDetailViewController: UIViewController {
    
    //MARK: Properties
    weak var coordinator: RecipiesCoordinatorProtocol?
    
    private let viewModel: RecipeDetailViewModelProtocol
    
    private let recipeLabel = UILabel()
    
    //MARK: Init
    init(viewModel: RecipeDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupContraints()
    }
}

//MARK: Setup UI
private extension RecipeDetailViewController {
    func setupViews() {
        view.backgroundColor = AppColors.baseCyan
        setupRecipesLabel()
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            recipeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            recipeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recipeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            recipeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func setupRecipesLabel() {
        recipeLabel.textAlignment = .center
        recipeLabel.textColor = AppColors.highlightYellow
        recipeLabel.font = .Roboto.bold.size(of: 24)
        recipeLabel.text = viewModel.recipeLabel
        recipeLabel.numberOfLines = 2
        view.addView(recipeLabel)
    }
    
}
