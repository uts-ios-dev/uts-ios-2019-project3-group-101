//
//  GroceriesTableViewController.swift
//  groceryList
//
//  Created by Divraj Singh on 22/5/19.
//  Copyright © 2019 Divraj Singh. All rights reserved.
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

    @IBAction func handleAdd(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //testing 1 2 3
    }
    
    // MARK: - Table view data source
    var myItemsFromCoreData = [Item]()


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
    
    /*override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }*/ // add test
 

}
