//
//  MyRecipesTableViewCell.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 29/04/24.
//

import UIKit
import Combine

final class MyRecipeTableViewCell: UITableViewCell {
    
    //MARK: Properties
    static let cellID = "MyRecipeTableViewCell"
    
    private let recipeImageView = CustomImageView()
    private let nameLabel = UILabel()
    private let mealTypeLabel = UILabel()
    private let cuisineTypeLabel = UILabel()
    private let labelsStackView = UIStackView()
    private let deleteButton = UIButton()
    
    private var viewModel: MyRecipeCellViewModelProtocol?
    
    private var cancellables = Set<AnyCancellable>()
    
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
    func configure(with viewModel: MyRecipeCellViewModelProtocol,
                   _ isEditingPublisher: AnyPublisher<Bool, Never>) {
        backgroundColor = .clear
        self.viewModel = viewModel
        
        recipeImageView.backgroundColor = .white
        nameLabel.text = viewModel.recipeLabel
        mealTypeLabel.text = viewModel.mealType
        cuisineTypeLabel.text = viewModel.cuisineType
        
        if let imageURL = URL(string: viewModel.image) {
            recipeImageView.loadImageWithUrl(imageURL)
        }
        
        bindIsEditing(isEditingPublisher)
    }
    
    func bindIsEditing(_ publisher: AnyPublisher<Bool, Never>) {
        publisher.sink { [weak self] isEditing in
            self?.deleteButton.isHidden = !isEditing
        }.store(in: &cancellables)
    }
    
    @objc private func deleteButtonTapped() {
        print("button tapped")
        viewModel?.deleteRecipe()
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
        setupDeleteButton()
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
            labelsStackView.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -5),
            
            deleteButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            deleteButton.heightAnchor.constraint(equalToConstant: 30),
            deleteButton.widthAnchor.constraint(equalToConstant: 30),
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
    
    private func setupDeleteButton() {
        deleteButton.setImage(UIImage(systemName: "minus.circle"), for: .normal)
        deleteButton.tintColor = .red
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        deleteButton.isHidden = true
        contentView.addView(deleteButton)
    }
}
