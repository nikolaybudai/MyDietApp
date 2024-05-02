//
//  MyRecipesViewController+TableView.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 28/04/24.
//

import UIKit

extension MyRecipesViewController {
    func setupTableView() {
        myRecipesTableView.separatorStyle = .none
        myRecipesTableView.backgroundColor = .clear
        myRecipesTableView.delegate = self
        myRecipesTableView.register(MyRecipeTableViewCell.self, forCellReuseIdentifier: MyRecipeTableViewCell.cellID)
        
        view.addView(myRecipesTableView)
    }
}

extension MyRecipesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let recipe = viewModel.myRecipesDiffableDataSource?.itemIdentifier(for: indexPath) else { return }
        coordinator?.showRecipeDetail(recipe: recipe)
    }
}
