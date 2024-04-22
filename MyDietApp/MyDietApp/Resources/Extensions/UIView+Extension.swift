//
//  UIView+Extension.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 08/04/24.
//

import UIKit

extension UIView {
    func addView(_ view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}
