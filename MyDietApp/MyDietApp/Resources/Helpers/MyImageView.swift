//
//  UIImageView+Extension.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 11/04/24.
//

import UIKit

class MyImageView: UIImageView {
    
    //MARK: Properties
    var imageURL: URL?
    let imageCache = NSCache<AnyObject, AnyObject>()
    
    let activityIndicator = UIActivityIndicatorView()
    
    init() {
        super.init(frame: .zero)
        setupActivityIndicator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: Loading Image
    func loadImageWithUrl(_ url: URL) {
        imageURL = url

        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = imageFromCache
            activityIndicator.stopAnimating()
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in

            if error != nil {
                print(error as Any)
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                }
                return
            }

            DispatchQueue.main.async {
                if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {
                    if self?.imageURL == url {
                        self?.image = imageToCache
                    }
                    self?.imageCache.setObject(imageToCache, forKey: url as AnyObject)
                }
                self?.activityIndicator.stopAnimating()
            }
        }).resume()
    }
}

//MARK: - Setup UI
private extension MyImageView {
    func setupActivityIndicator() {
        activityIndicator.color = .darkGray

        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        image = nil
        activityIndicator.startAnimating()
    }
}
