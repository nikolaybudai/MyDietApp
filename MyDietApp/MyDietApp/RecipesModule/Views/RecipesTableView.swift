//
//  RecipesTableView.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 08/04/24.
//

import UIKit

final class RecipesTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        setup()
        registerCells()
        setDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        separatorStyle = .none
        backgroundColor = .clear
    }
    
    private func setDelegate() {
        delegate = self
    }
    
    private func registerCells() {
        register(RecipeTableViewCell.self, forCellReuseIdentifier: RecipeTableViewCell.cellID)
    }
}

extension RecipesTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
}

//extension RecipesTableView: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { [weak self] timer in
//            let offset = scrollView.contentOffset.y
//            let totalContentheight = scrollView.contentSize.height
//            let totalScrollViewFixedHeight = scrollView.frame.size.height
//            
//            if offset >= (totalContentheight - totalScrollViewFixedHeight - 120) {
//                self?.
//            }
//            timer.invalidate()
//        }
//    }
//}
