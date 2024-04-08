//
//  RecipesTableViewDataSource.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 08/04/24.
//

import UIKit

enum RecipeSection {
    case recipe
}

enum RecipeRow: Hashable {    
    case recipe(Recipe)
}

final class RecipesTableViewDataSource: UITableViewDiffableDataSource<RecipeSection, RecipeRow> {
    
    init(tableView: UITableView) {
        super.init(tableView: tableView) { tableView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .recipe(let model): break
                //                let cell = tableView.dequeueReusableCell(withIdentifier: SubscribeTableViewCell.cellID,
                //                                                         for: indexPath) as? SubscribeTableViewCell
                //                cell?.configure(model)
                //                return cell ?? UITableViewCell()
            }
            return UITableViewCell()
        }
    }
}
