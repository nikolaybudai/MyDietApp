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
    let myRecipesTableView = UITableView()
    
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
        setupTableView()
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            buttonsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 40),
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
        var menuChildren: [UIMenuElement] = []
        let dataSource = viewModel.mealTypeOptions
        let handler = viewModel.mealTypeChoiceHandler
        
        for meal in dataSource {
            menuChildren.append(UIAction(title: meal, handler: handler))
        }

        mealTypeChoiceButton.menu = UIMenu(options: .displayInline, children: menuChildren)

        mealTypeChoiceButton.showsMenuAsPrimaryAction = true
        mealTypeChoiceButton.changesSelectionAsPrimaryAction = true
        
        mealTypeChoiceButton.setTitle("Meal", for: .normal)
        mealTypeChoiceButton.backgroundColor = AppColors.highlightYellow
        mealTypeChoiceButton.layer.cornerRadius = 7
        mealTypeChoiceButton.setTitleColor(AppColors.secondaryDark, for: .normal)
        mealTypeChoiceButton.titleLabel?.font = UIFont.Roboto.medium.size(of: 22)
    }
    
    private func setupCuisineTypeChoiceButton() {
        var menuChildren: [UIMenuElement] = []
        let dataSource = viewModel.cuisineTypeOptions
        let handler = viewModel.cuisineTypeChoiceHandler
        
        for cuisine in dataSource {
            menuChildren.append(UIAction(title: cuisine, handler: handler))
        }

        cuisineTypeChoiceButton.menu = UIMenu(options: .displayInline, children: menuChildren)

        cuisineTypeChoiceButton.showsMenuAsPrimaryAction = true
        cuisineTypeChoiceButton.changesSelectionAsPrimaryAction = true
        
        cuisineTypeChoiceButton.setTitle("Cuisine", for: .normal)
        cuisineTypeChoiceButton.backgroundColor = AppColors.highlightYellow
        cuisineTypeChoiceButton.layer.cornerRadius = 7
        cuisineTypeChoiceButton.setTitleColor(AppColors.secondaryDark, for: .normal)
        cuisineTypeChoiceButton.titleLabel?.font = UIFont.Roboto.medium.size(of: 22)
    }
    
    private func setupButtonsStackView() {
        buttonsStackView.axis = .horizontal
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = 20
        
        buttonsStackView.addArrangedSubview(mealTypeChoiceButton)
        buttonsStackView.addArrangedSubview(cuisineTypeChoiceButton)
        view.addView(buttonsStackView)
    }
}

