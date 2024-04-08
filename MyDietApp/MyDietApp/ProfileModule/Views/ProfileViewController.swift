//
//  ProfileViewController.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 30/03/24.
//

import UIKit
import PhotosUI

final class ProfileViewController: UIViewController {
    
    //MARK: Properties
    weak var coordinator: ProfileCoordinatorProtocol?
    
    let viewModel: ProfileViewModelProtocol
    
    private let avatarImageView = UIImageView()
    private let nameTextField = UITextField()
    private let dietChoiceButton = UIButton()
    private let saveButton = UIButton()
    private let stackView = UIStackView()
    
    //MARK: Init
    init(viewModel: ProfileViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        setupViews()
        setupConstraints()
        setUserInfo()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.height / 2
    }
    
    //MARK: Methods
    @objc private func didTapImageView() {
        configureImagePicker()
    }
    
    @objc private func didTapSaveButton() {
        let diets = viewModel.dietOptions
        let chosenDiet = dietChoiceButton.titleLabel?.text ?? ""
        viewModel.dietChosen = chosenDiet
        
        guard diets.contains(chosenDiet), let name = nameTextField.text,
              let image = avatarImageView.image else {
            showAlert(title: "Empty fields!", message: "You should feel all the information.")
            return
        }
        
        viewModel.saveUserData(image, name)
    }
    
    private func setUserInfo() {
        let (image, name, diet) = viewModel.loadUserInfo()
        guard let image, let name, let diet else { return }
        avatarImageView.image = image
        nameTextField.text = name
        dietChoiceButton.setTitle(diet, for: .normal)
    }
    
}

//MARK: - Setup UI
private extension ProfileViewController {
    func setupViews() {
        view.backgroundColor = AppColors.baseCyan
        setupAvatarImageView()
        setupNameTextField()
        setupDietChoiceButton()
        setupSaveButton()
        setupStackView()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 40),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            dietChoiceButton.heightAnchor.constraint(equalToConstant: 44),
            saveButton.heightAnchor.constraint(equalToConstant: 44),
        ])
        
    }
    
    private func setupAvatarImageView() {
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.borderWidth = 1
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.image = UIImage(systemName: "person.circle")
        avatarImageView.tintColor = AppColors.baseGray
        view.addView(avatarImageView)
        
        // Add gesture recognizer
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapImageView))
        avatarImageView.addGestureRecognizer(gestureRecognizer)
        avatarImageView.isUserInteractionEnabled = true
    }
    
    private func configureImagePicker(){
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .images
        let pickerViewController = PHPickerViewController(configuration: configuration)
        pickerViewController.delegate = self
        present(pickerViewController, animated: true)
    }
    
    private func setupNameTextField() {
        nameTextField.backgroundColor = AppColors.baseGray
        nameTextField.placeholder = " Enter your name"
        nameTextField.layer.cornerRadius = 5
        nameTextField.keyboardType = .default
        nameTextField.font = .Roboto.medium.size(of: 18)
        nameTextField.textColor = AppColors.secondaryDark
        nameTextField.textAlignment = .center
        nameTextField.delegate = self
    }
    
    private func setupDietChoiceButton() {
        var menuChildren: [UIMenuElement] = []
        let dataSource = viewModel.dietOptions
        let handler = viewModel.dietChoiceHandler
        
        for diet in dataSource {
            menuChildren.append(UIAction(title: diet, handler: handler))
        }

        dietChoiceButton.menu = UIMenu(options: .displayInline, children: menuChildren)

        dietChoiceButton.showsMenuAsPrimaryAction = true
        dietChoiceButton.changesSelectionAsPrimaryAction = true
        
        dietChoiceButton.setTitle("Choose your diet", for: .normal)
        dietChoiceButton.backgroundColor = AppColors.highlightYellow
        dietChoiceButton.layer.cornerRadius = 7
        dietChoiceButton.setTitleColor(AppColors.secondaryDark, for: .normal)
        dietChoiceButton.titleLabel?.font = UIFont.Roboto.medium.size(of: 22)
    }
    
    private func setupSaveButton() {
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = AppColors.highlightYellow
        saveButton.layer.cornerRadius = 7
        saveButton.setTitleColor(AppColors.secondaryDark, for: .normal)
        saveButton.titleLabel?.font = UIFont.Roboto.bold.size(of: 24)
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
    }
    
    private func setupStackView() {
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(dietChoiceButton)
        stackView.addArrangedSubview(saveButton)
        
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        view.addView(stackView)
    }
}

//MARK: - PHPickerViewControllerDelegate
extension ProfileViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        if let itemprovider = results.first?.itemProvider {
            if itemprovider.canLoadObject(ofClass: UIImage.self) {
                itemprovider.loadObject(ofClass: UIImage.self) { image , error  in
                    if let selectedImage = image as? UIImage{
                        DispatchQueue.main.async {
                            self.avatarImageView.image = selectedImage
                        }
                    }
                }
            }
        }
    }
}

//MARK: - UITextFieldDelegate
extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
