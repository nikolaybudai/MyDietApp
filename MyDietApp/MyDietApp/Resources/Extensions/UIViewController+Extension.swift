//
//  UIViewController+Extension.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 01/04/24.
//

import UIKit

extension UIViewController {
    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.present(alert, animated: true)
        }
    }
}
