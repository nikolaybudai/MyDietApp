//
//  ViewController.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 28/03/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel()
        label.text = "Test text"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = .Roboto.lightItalic.size(of: 40)
        label.textColor = .white
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        view.backgroundColor = .blue
    }


}

