//
//  RecipesTableView.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 08/04/24.
//

import UIKit

final class RecipesTableView: UITableView {
//    private var subscribeTypes: [ExampleRow] = [.subscribeType(SubscribeModel.betaSubs),
//                                                .subscribeType(SubscribeModel.juniorSubs)]
//    private var payment: [ExampleRow] = []
//    private var discount: [ExampleRow] = []
//    
//    private lazy var exampleDataSource = ExampleDataSource(tableView: self)
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        registerCells()
        applySnapshot()
        setDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setDelegate() {
        delegate = self
    }
    
    private func registerCells() {

    }
    
    func applySnapshot() {
    }
}

extension RecipesTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        40
    }
    
}
