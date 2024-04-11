//
//  RecipeTableViewCell.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 09/04/24.
//

import UIKit

final class RecipeTableViewCell: UITableViewCell {
    
    //MARK: Properties
    static let cellID = "RecipeTableViewCell"
    
    private let recipeImageView = MyImageView()
    private let nameLabel = UILabel()
    private let mealTypeLabel = UILabel()
    private let favouritesButton = UIButton()
    
    private let labelsStackView = UIStackView()
    
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
    
    //MARK: Methods
    func configure(_ model: Recipe) {
        backgroundColor = .clear
        recipeImageView.backgroundColor = .white
        nameLabel.text = model.label
        mealTypeLabel.text = model.mealType.first
        
        if let imageURL = URL(string: model.image) {
            recipeImageView.loadImageWithUrl(imageURL)
        }
    }
    
    @objc private func didTapFavouritesButton() {
        favouritesButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        favouritesButton.tintColor = AppColors.highlightYellow
        print("tapped star")
    }
}

//MARK: Setup UI
private extension RecipeTableViewCell {
    func setupViews() {
        setupNameLabel()
        setupRecipeImageView()
        setupMealTypeLabel()
        setupLabelsStackView()
        setupFavouritesButton()
        contentView.isUserInteractionEnabled = false
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            recipeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            recipeImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            recipeImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            recipeImageView.widthAnchor.constraint(equalTo: recipeImageView.heightAnchor),
            
            favouritesButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            favouritesButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            favouritesButton.widthAnchor.constraint(equalToConstant: 40),
            favouritesButton.heightAnchor.constraint(equalTo: favouritesButton.widthAnchor),
            
            labelsStackView.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 5),
            labelsStackView.topAnchor.constraint(equalTo: recipeImageView.topAnchor),
            labelsStackView.bottomAnchor.constraint(equalTo: recipeImageView.bottomAnchor),
            labelsStackView.trailingAnchor.constraint(equalTo: favouritesButton.leadingAnchor, constant: -5),
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
    
    func setupMealTypeLabel() {
        mealTypeLabel.font = .Roboto.italic.size(of: 14)
        mealTypeLabel.textAlignment = .left
        mealTypeLabel.textColor = AppColors.secondaryDark
    }
    
    func setupLabelsStackView() {
        labelsStackView.addArrangedSubview(nameLabel)
        labelsStackView.addArrangedSubview(mealTypeLabel)
        labelsStackView.axis = .vertical
        labelsStackView.alignment = .leading
        labelsStackView.distribution = .fillProportionally
        addView(labelsStackView)
    }
    
    func setupFavouritesButton() {
        favouritesButton.setImage(UIImage(systemName: "star"), for: .normal)
        favouritesButton.tintColor = AppColors.highlightYellow
        favouritesButton.addTarget(self, action: #selector(didTapFavouritesButton), for: .touchUpInside)
        addView(favouritesButton)
    }
}
