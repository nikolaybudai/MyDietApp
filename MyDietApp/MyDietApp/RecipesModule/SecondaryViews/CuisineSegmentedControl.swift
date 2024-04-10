//
//  RecipesSegmentedControl.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 08/04/24.
//

import UIKit
import Combine

final class CuisineSegmentedControl: UIView {
    
    var selectedCuisineIndex = CurrentValueSubject<Int, Never>(0)
    
    //MARK: Properties
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        
        segmentedControl.selectedSegmentTintColor = .clear
        
        segmentedControl.insertSegment(withTitle: CuisineType.american.rawValue, at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: CuisineType.italian.rawValue, at: 1, animated: true)
        segmentedControl.insertSegment(withTitle: CuisineType.chinese.rawValue, at: 2, animated: true)

        segmentedControl.selectedSegmentIndex = 0

        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: AppColors.baseGray,
            NSAttributedString.Key.font: UIFont.Roboto.regular.size(of: 18)], for: .normal)

        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: AppColors.highlightYellow,
            NSAttributedString.Key.font: UIFont.Roboto.bold.size(of: 18)], for: .selected)

        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)

        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    private lazy var bottomUnderlineView: UIView = {
        let underlineView = UIView()
        underlineView.backgroundColor = AppColors.highlightYellow
        return underlineView
    }()
    
    private lazy var leadingDistanceConstraint: NSLayoutConstraint = {
        return bottomUnderlineView.leftAnchor.constraint(equalTo: segmentedControl.leftAnchor)
    }()
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let segmentIndex = segmentedControl.selectedSegmentIndex
        selectedCuisineIndex.send(segmentIndex)
        
        let segmentWidth = CGFloat(segmentedControl.frame.width) / CGFloat(segmentedControl.numberOfSegments)
        let leadingDistance = segmentWidth * CGFloat(segmentIndex)
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.leadingDistanceConstraint.constant = leadingDistance
            self?.layoutIfNeeded()
        })
    }
    
}

//MARK: - Constraints
private extension CuisineSegmentedControl {
    func setupView() {
        backgroundColor = .clear
        addView(segmentedControl)
        addView(bottomUnderlineView)
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor),
            segmentedControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            segmentedControl.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            bottomUnderlineView.bottomAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            bottomUnderlineView.heightAnchor.constraint(equalToConstant: 2),
            leadingDistanceConstraint,
            bottomUnderlineView.widthAnchor.constraint(equalTo: segmentedControl.widthAnchor, multiplier: 1 / CGFloat(segmentedControl.numberOfSegments)),
        ])
    }
}
