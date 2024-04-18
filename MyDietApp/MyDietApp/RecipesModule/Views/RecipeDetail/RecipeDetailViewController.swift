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
    private let recipeImageView = CustomImageView()
    private let caloriesLabel = UILabel()
    private let cuisineTypeLabel = UILabel()
    private let mealTypeLabel = UILabel()
    private let labelsStackView = UIStackView()
    
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
        setupRecipeImageView()
        setupLabelsStackView()
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            recipeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            recipeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            recipeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            recipeLabel.heightAnchor.constraint(equalToConstant: 60),
            
            recipeImageView.topAnchor.constraint(equalTo: recipeLabel.bottomAnchor, constant: 15),
            recipeImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recipeImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            recipeImageView.heightAnchor.constraint(equalTo: recipeImageView.widthAnchor),
            
            labelsStackView.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 15),
            labelsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            labelsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            labelsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
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
    
    func setupRecipeImageView() {
        recipeImageView.contentMode = .scaleAspectFit
        recipeImageView.clipsToBounds = true
        
        if let imageURL = URL(string: viewModel.image) {
            recipeImageView.loadImageWithUrl(imageURL)
        }
        
        view.addView(recipeImageView)
    }
    
    func setupCaloriesLabel() {
        caloriesLabel.textAlignment = .center
        caloriesLabel.font = .Roboto.medium.size(of: 22)
        caloriesLabel.textColor = AppColors.highlightYellow
        caloriesLabel.text = String(viewModel.calories.rounded()) + " kcal"
    }
    
    func setupCuisineTypeLabel() {
        cuisineTypeLabel.textAlignment = .center
        cuisineTypeLabel.font = .Roboto.medium.size(of: 20)
        cuisineTypeLabel.textColor = AppColors.secondaryDark
        cuisineTypeLabel.text = (viewModel.cuisineType.first?.capitalized ?? "") + " cuisine"
    }
    
    func setupMealTypeLabel() {
        mealTypeLabel.textAlignment = .center
        mealTypeLabel.font = .Roboto.medium.size(of: 22)
        mealTypeLabel.textColor = AppColors.secondaryDark
        mealTypeLabel.text = "Meal: " + (viewModel.mealType.first ?? "")
    }
    
    func setupLabelsStackView() {
        labelsStackView.axis = .vertical
        labelsStackView.distribution = .fillProportionally
        
        labelsStackView.addArrangedSubview(caloriesLabel)
        labelsStackView.addArrangedSubview(cuisineTypeLabel)
        labelsStackView.addArrangedSubview(mealTypeLabel)
        
        setupCaloriesLabel()
        setupCuisineTypeLabel()
        setupMealTypeLabel()
        
        view.addView(labelsStackView)
    }
    
}
