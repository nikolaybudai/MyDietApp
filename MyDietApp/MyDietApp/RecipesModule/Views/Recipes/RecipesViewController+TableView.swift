//
//  RecipesViewController+TableView.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 18/04/24.
//

import UIKit

extension RecipesViewController {
    func setupTableView() {
        recipesTableView.separatorStyle = .none
        recipesTableView.backgroundColor = .clear
        recipesTableView.delegate = self
        recipesTableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: RecipeTableViewCell.cellID)
        recipesTableView.tableFooterView = tableViewFooter
        
        view.addView(recipesTableView)
    }
}

extension RecipesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let recipe = viewModel.recipesDiffableDataSource?.itemIdentifier(for: indexPath) else { return }
        coordinator?.showRecipeDetail(recipe: recipe)
    }
}

extension RecipesViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !viewModel.isLoadingMoreRecipes else { return }
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] timer in
            let offset = scrollView.contentOffset.y
            let totalContentheight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height

            if offset >= (totalContentheight - totalScrollViewFixedHeight - 120) {
                guard let newEnpoint = self?.viewModel.currentNextEndpoint else { return }
                self?.viewModel.fetchMoreRecipes(with: newEnpoint)
            }
            timer.invalidate()
        }
    }
}
