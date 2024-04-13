//
//  RecipesViewController.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 07/04/24.
//

import UIKit
import Combine

final class RecipesViewController: UIViewController {
    
    //MARK: Properties
    weak var coordinator: RecipiesCoordinatorProtocol?
    
    let viewModel: RecipesViewModelProtocol
    
    private let cuisineTypeLabel = UILabel()
    private let cuisineSegmentedControl = CuisineSegmentedControl(frame: .zero)
    private let recipesTableView = UITableView()
    private lazy var tableViewFooter = RecipesTableViewFooter(frame: CGRect(x: 0, y: 0,
                                                                       width: view.frame.width,
                                                                       height: 200))
    
    var subscriptions = Set<AnyCancellable>()
    
    //MARK: Init
    init(viewModel: RecipesViewModelProtocol) {
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
        setupConstraints()
        setupTableViewDataSource()
        setupSubscriptions()
        
        viewModel.fetchRecipes(with: viewModel.currentCuisineTypeIndex)
    }
    
    //MARK: Methods
    private func setupSubscriptions() {
        viewModel.hasFailure.sink { [weak self] value in
            if value == true {
                self?.showAlert(title: "Error", message: "Coludn't load recipes. Please, try again later.")
            }
        }.store(in: &subscriptions)
        
        cuisineSegmentedControl.selectedCuisineIndex.sink { [weak self] index in
            self?.viewModel.fetchRecipes(with: index)
        }.store(in: &subscriptions)
        
        viewModel.isLoading
            .receive(on: RunLoop.main)
            .sink { [weak self] isLoading in
            if isLoading {
                self?.tableViewFooter.updateProgress(to: 1, animated: true)
            } else {
                self?.tableViewFooter.resetProgress(to: 0, animated: false)
            }
        }.store(in: &subscriptions)
    }
    
    private func setupTableViewDataSource() {
        viewModel.recipesDiffableDataSource = UITableViewDiffableDataSource(tableView: recipesTableView) { (tableView, indexPath, recipe) -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTableViewCell.cellID,
                                                           for: indexPath) as? RecipeTableViewCell
                    else { return UITableViewCell() }
                    
            cell.configure(recipe)
            return cell
        }
    }
    
}

//MARK: - Setup UI
private extension RecipesViewController {
    func setupViews() {
        view.backgroundColor = AppColors.baseCyan
        title = "Recipes"
        setupNavigationBar()
        setupCuisineTypeLabel()
        setupTableView()
        view.addView(cuisineSegmentedControl)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            cuisineTypeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            cuisineTypeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cuisineTypeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cuisineTypeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            cuisineSegmentedControl.topAnchor.constraint(equalTo: cuisineTypeLabel.bottomAnchor, constant: 10),
            cuisineSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cuisineSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            cuisineSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            cuisineSegmentedControl.heightAnchor.constraint(equalToConstant: 40),
            
            recipesTableView.topAnchor.constraint(equalTo: cuisineSegmentedControl.bottomAnchor, constant: 10),
            recipesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            recipesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recipesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
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
    
    private func setupCuisineTypeLabel() {
        cuisineTypeLabel.text = "Cuisine Type"
        cuisineTypeLabel.font = .Roboto.medium.size(of: 20)
        cuisineTypeLabel.textAlignment = .center
        cuisineTypeLabel.textColor = AppColors.secondaryDark
        view.addView(cuisineTypeLabel)
    }
    
    private func setupTableView() {
        recipesTableView.separatorStyle = .none
        recipesTableView.backgroundColor = .clear
        recipesTableView.delegate = viewModel
        recipesTableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: RecipeTableViewCell.cellID)
        recipesTableView.tableFooterView = tableViewFooter
        
        view.addView(recipesTableView)
    }
    
}
