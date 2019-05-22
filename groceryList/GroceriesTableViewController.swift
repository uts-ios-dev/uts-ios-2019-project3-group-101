//
//  GroceriesTableViewController.swift
//  GroceryList
//
//  Created by Jessie Chan on 22/5/19.
//  Copyright © 2019 UTS. All rights reserved.
//

import UIKit

extension ItemEntity {
    
    func toItem() -> Item {
        return Item(item: self.item!)
    }
    
}

class GroceriesTableViewController: UITableViewController {
    
    @IBOutlet var groceryTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //createEntries()
        populateItemsFromCoreData()
    }
    
    @IBAction func handleAdd(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //testing 1 2 3
    }
    
    // MARK: - Table view data source
    var myItemsFromCoreData: [Item] = [Item]()
    
    func populateItemsFromCoreData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let items = appDelegate.getItems()
        myItemsFromCoreData = items.map({$0.toItem()})
    }
    
    func createEntries() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.saveItem(item: "Carrots")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myItemsFromCoreData.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groceryItemCell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = myItemsFromCoreData[indexPath.row].item
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            myItemsFromCoreData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
        }
    }
    
    
}
