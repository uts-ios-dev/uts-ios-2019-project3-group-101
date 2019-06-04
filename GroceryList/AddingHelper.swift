//
//  AddingHelper.swift
//  GroceryList
//
//  Created by Jelisha De La Cruz on 5/6/19.
//  Copyright © 2019 UTS. All rights reserved.
//

import Foundation

class AddingHelper {
    
    static let sharedInstance = AddingHelper()
    
    func add(items: [String]) {
        GroceriesTableViewController.sharedInstance.addItems(items: items)
    }
}
