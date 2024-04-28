//
//  MyRecipesViewController.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 19/04/24.
//

import UIKit

final class MyRecipesViewController: UIViewController {
    
    //MARK: Properties
    weak var coordinator: MyRecipiesCoordinatorProtocol?
    
    private let viewModel: MyRecipesViewModelProtocol
    
    private let mealTypeChoiceButton = UIButton()
    private let cuisineTypeChoiceButton = UIButton()
    private let buttonsStackView = UIStackView()
    
    //MARK: Init
    init(viewModel: MyRecipesViewModelProtocol) {
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
private extension MyRecipesViewController {
    func setupViews() {
        title = "My Recipes"
        view.backgroundColor = AppColors.baseCyan
        setupNavigationBar()
        setupMealTypeChoiceButton()
        setupCuisineTypeChoiceButton()
        setupButtonsStackView()
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
    
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = AppColors.baseCyan
        appearance.titleTextAttributes = [.font: UIFont.Roboto.bold.size(of: 28),
                                          .foregroundColor: AppColors.secondaryDark]

        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setupMealTypeChoiceButton() {
        
    }
    
    private func setupCuisineTypeChoiceButton() {
        
    }
    
    private func setupButtonsStackView() {
        
    }
}

