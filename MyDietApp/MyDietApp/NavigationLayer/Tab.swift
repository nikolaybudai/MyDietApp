//
//  Tabs.swift
//  MyDietApp
//
//  Created by Nikolay Budai on 02/04/24.
//

import Foundation

enum Tab {
    case recipies
    case myRecipies
    case profile

    func getIndex() -> Int {
        switch self {
        case .recipies: return 0
        case .myRecipies: return 1
        case .profile: return 2
        }
    }

    func getTitleName() -> String {
        switch self {
        case .recipies: return "Recipies"
        case .myRecipies: return "My Recipies"
        case .profile: return "Profile"
        }
    }

    func getIconName() -> String {
        switch self {
        case .recipies: return "fork.knife.circle"
        case .myRecipies: return "bookmark.circle"
        case .profile: return "person.crop.circle"
        }
    }
}
