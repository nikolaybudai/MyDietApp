//
//  MyRecipesTableViewCell.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 29/04/24.
//

import UIKit

final class MyRecipeTableViewCell: UITableViewCell {
    
    //MARK: Properties
    static let cellID = "RecipeTableViewCell"
    
    private let recipeImageView = CustomImageView()
    private let nameLabel = UILabel()
    private let mealTypeLabel = UILabel()
    private let cuisineTypeLabel = UILabel()
    private let labelsStackView = UIStackView()
    
    private var viewModel: MyRecipeCellViewModelProtocol?
    
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
    func configure(with viewModel: MyRecipeCellViewModelProtocol) {
        backgroundColor = .clear
        self.viewModel = viewModel
        
        recipeImageView.backgroundColor = .white
        nameLabel.text = viewModel.recipeLabel
        mealTypeLabel.text = viewModel.mealType
        cuisineTypeLabel.text = viewModel.cuisineType
        
        if let imageURL = URL(string: viewModel.image) {
            recipeImageView.loadImageWithUrl(imageURL)
        }
    }
}

//MARK: - Setup UI
private extension MyRecipeTableViewCell {
    func setupViews() {
        setupRecipeImageView()
        setupNameLabel()
        setupMealTypelabel()
        setupCuisineTypeLabel()
        setupLabelsStackView()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            recipeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            recipeImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            recipeImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            recipeImageView.widthAnchor.constraint(equalTo: recipeImageView.heightAnchor),
            
            labelsStackView.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 10),
            labelsStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            labelsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            labelsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }
    
    func setupRecipeImageView() {
        recipeImageView.contentMode = .scaleAspectFit
        recipeImageView.clipsToBounds = true
        addView(recipeImageView)
    }
    
    func setupNameLabel() {
        nameLabel.font = .Roboto.regular.size(of: 16)
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .left
        nameLabel.textColor = AppColors.secondaryDark
    }
    
    func setupMealTypelabel() {
        mealTypeLabel.font = .Roboto.regular.size(of: 14)
        mealTypeLabel.textAlignment = .left
        mealTypeLabel.textColor = AppColors.secondaryDark
    }
    
    func setupCuisineTypeLabel() {
        mealTypeLabel.font = .Roboto.italic.size(of: 14)
        mealTypeLabel.textAlignment = .left
        mealTypeLabel.textColor = AppColors.secondaryDark
    }
    
    func setupLabelsStackView() {
        labelsStackView.axis = .vertical
        labelsStackView.distribution = .fillProportionally
        labelsStackView.spacing = 5
        
        labelsStackView.addArrangedSubview(nameLabel)
        labelsStackView.addArrangedSubview(mealTypeLabel)
        labelsStackView.addArrangedSubview(cuisineTypeLabel)
        addView(labelsStackView)
    }
}
