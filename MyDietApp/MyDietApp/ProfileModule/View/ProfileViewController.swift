//
//  ProfileViewController.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 30/03/24.
//

import UIKit
import PhotosUI

final class ProfileViewController: UIViewController {
    
    weak var coordinator: ProfileCoordinator?
    
    let viewModel: ProfileViewModelProtocol
    
    private let avatarImageView = UIImageView()
    
    //MARK: - Init
    init(viewModel: ProfileViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        setupViews()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.height / 2
    }
    
    @objc private func didTapImageView() {
        configureImagePicker()
    }
    
}

private extension ProfileViewController {
    func setupViews() {
        view.backgroundColor = AppColors.baseCyan
        setupAvatarImageView()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
        ])
        
    }
    
    private func setupAvatarImageView() {
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.borderWidth = 1
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.image = UIImage(systemName: "person.circle")
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.tintColor = .white
        view.addSubview(avatarImageView)
        
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
}


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
