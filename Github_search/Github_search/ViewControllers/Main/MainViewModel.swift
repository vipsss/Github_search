//
//  MainViewModel.swift
//  Github_search
//
//  Created by Mac User on 14.02.2023.
//

import Foundation

class MainViewModel {
    
    let title = "Github search app"
    var listItems: [Repository] = []
    
    func updateListItems(_ items: [Repository]) {
        self.listItems = items
    }
}
