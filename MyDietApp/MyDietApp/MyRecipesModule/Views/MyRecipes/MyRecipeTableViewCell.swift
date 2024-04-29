//
//  MyRecipesTableViewCell.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 29/04/24.
//

import UIKit

final class MyRecipeTableViewCell: UITableViewCell {
    
    //MARK: Properties
    private let recipeImageView = CustomImageView()
    private let nameLabel = UILabel()
    private let mealTypeLabel = UILabel()
    private let cuisineTypeLabel = UILabel()
    private let labelsStackView = UIStackView()
    
    private var viewModel: MyRecipesViewModelProtocol?
    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: methods
    func configure(with viewModel: MyRecipesViewModelProtocol) {
        backgroundColor = .clear
        self.viewModel = viewModel
        
//        recipeImageView.backgroundColor = .white
//        nameLabel.text = viewModel.recipeLabel
//        mealTypeLabel.text = viewModel.mealType
//        
//        if let imageURL = URL(string: viewModel.image) {
//            recipeImageView.loadImageWithUrl(imageURL)
//        }
        
//        setupSubscriptions()
    }
}

//MARK: - Setup UI
private extension MyRecipeTableViewCell {
    func setupViews() {
        setupNameLabel()
        setupMealTypelabel()
        setupCuisineTypeLabel()
        setupLabelsStackView()
    }
    
    func setupConstraints() {
        
    }
    
    private func setupNameLabel() {
        
    }
    
    private func setupMealTypelabel() {
        
    }
    
    private func setupCuisineTypeLabel() {
        
    }
    
    private func setupLabelsStackView() {
        labelsStackView.addArrangedSubview(nameLabel)
        labelsStackView.addArrangedSubview(mealTypeLabel)
        labelsStackView.addArrangedSubview(cuisineTypeLabel)
        addView(labelsStackView)
    }
}
