//
//  RecipesViewController.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 07/04/24.
//

import UIKit

final class RecipesViewController: UIViewController {
    
    //MARK: Properties
    weak var coordinator: RecipiesCoordinatorProtocol?
    
    let viewModel: RecipesViewModelProtocol
    
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
        
    }
    
}

//MARK: - Setup UI
private extension RecipesViewController {
    func setupViews() {
        
    }
    
    func setupConstraints() {
        
    }
}
