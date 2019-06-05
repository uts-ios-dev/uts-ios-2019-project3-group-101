//
//  ViewController.swift
//  GroceryNow
//
//  Created by Divraj Singh on 5/6/19.
//  Copyright © 2019 Divraj Singh. All rights reserved.
//

import UIKit

var items = [String]()

class ViewController: UIViewController {

    @IBOutlet var groceriesTableView: UITableView!
    static let sharedInstance = ViewController()
    static let GroupId = "group.shared.demo2"
    let sharedDefaults = UserDefaults(suiteName: ViewController.GroupId)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getData()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.getData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        self.storeData()
    }

    @IBAction func handleAdd(_ sender: Any) {
        let alert = UIAlertController(title: "Add Grocery", message: nil, preferredStyle: .alert)
        alert.addTextField { (itemTf) in
            itemTf.placeholder = "Enter Grocery Item"
        }
        let action = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let item = alert.textFields?.first?.text else { return }
            var itemStrings = [String]()
            itemStrings.append(item)
            self.add(groceries: itemStrings)
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func add(groceries: [String]) {
        items.append(contentsOf: groceries)
        let indexPath = IndexPath(row: items.count - 1, section: 0)
        self.groceriesTableView.insertRows(at: [indexPath], with: .fade)
        self.storeData()
    }
    
    func reloadTableView() {
        self.groceriesTableView.reloadData()
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let item = items[indexPath.row]
        cell.textLabel?.text = item
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        items.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        storeData()
    }
    

    //store app data
    func storeData() {
        sharedDefaults?.set(items, forKey: "savedData")
        sharedDefaults?.synchronize()
    }
    
    //get app data
    func getData() {
        let data = sharedDefaults?.value(forKey: "savedData")
        if data != nil {
            items = data as! [String]
        } else {}
    }
}

