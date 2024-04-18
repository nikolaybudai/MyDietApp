//
//  RecipesTableViewFooter.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 13/04/24.
//

import UIKit

final class RecipesTableViewFooter: UIView {
    
    //MARK: Properties
    let progressView = UIProgressView()
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    func updateProgress(to progress: Float, animated: Bool) {
        progressView.setProgress(progress, animated: animated)
    }
    
    func resetProgress(to progress: Float, animated: Bool) {
        progressView.setProgress(0, animated: animated)
    }
}

//MARK: - SetupUI
private extension RecipesTableViewFooter {
    func setupView() {
        setupProgressView()
    }
    
    func setupProgressView() {
        progressView.setProgress(0.1, animated: true)
        progressView.tintColor = AppColors.baseGray
        progressView.progressTintColor = AppColors.highlightYellow
        addView(progressView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            progressView.centerXAnchor.constraint(equalTo: centerXAnchor),
            progressView.centerYAnchor.constraint(equalTo: centerYAnchor),
            progressView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
        ])
    }
}
