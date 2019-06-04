//
//  GroceriesTableViewController.swift
//  GroceryList
//
//  Created by Jessie Chan on 22/5/19.
//  Copyright © 2019 UTS. All rights reserved.
//

import UIKit
import CoreData

extension ItemEntity {
    
    func toItem() -> Item {
        return Item(item: self.item!)
    }
    
}

class GroceriesTableViewController: UITableViewController {
    
    var resultsController: NSFetchedResultsController<ItemEntity>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let items = appDelegate.getItems()
        //Request
        let request : NSFetchRequest<ItemEntity> = ItemEntity.fetchRequest()
        let sortDecriptors = NSSortDescriptor(key: "item", ascending: true)
        request.sortDescriptors = [sortDecriptors]
        //Init
        resultsController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: appDelegate.managedContext!,
            sectionNameKeyPath: nil,
            cacheName: nil)
        resultsController.delegate = self
        //Fetch
        do {
            try resultsController.performFetch()
        } catch {
            print("Peform fetch error \(error)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        //Request
//        let request : NSFetchRequest<ItemEntity> = ItemEntity.fetchRequest()
//        let sortDecriptors = NSSortDescriptor(key: "item", ascending: true)
//        request.sortDescriptors = [sortDecriptors]
//        //Init
//        resultsController = NSFetchedResultsController(
//            fetchRequest: request,
//            managedObjectContext: appDelegate.managedContext!,
//            sectionNameKeyPath: nil,
//            cacheName: nil)
//        resultsController.delegate = self
//        //Fetch
//        do {
//            try resultsController.performFetch()
//        } catch {
//            print("Peform fetch error \(error)")
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let _ = sender as? UIBarButtonItem, let vc = segue.destination as? AddViewController {
            vc.managedContext = resultsController.managedObjectContext
        }
    }

    
    // MARK: - Table view data source
//    var myItemsFromCoreData: [Item] = [Item]()
//    
//    func populateItemsFromCoreData() {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let items = appDelegate.getItems()
//        myItemsFromCoreData = items.map({$0.toItem()})
//    }
    
//    func createEntries() {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.saveItem(item: "Carrots")
//    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return resultsController.sections?[section].objects?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groceryCell", for: indexPath)
        
        // Configure the cell...
        //cell.textLabel?.text = myItemsFromCoreData[indexPath.row].item
        configureCell(cell, at: indexPath)
        return cell
    }
    
    func configureCell(_ cell: UITableViewCell, at indexPath: IndexPath) {
        let groceryItem = resultsController.object(at: indexPath)
        cell.textLabel?.text = groceryItem.item
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        
        // Fetch record
        let record = resultsController.object(at: indexPath)
        
        // Delete record
        resultsController.managedObjectContext.delete(record)
    }
}

extension GroceriesTableViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath, let cell = tableView.cellForRow(at: indexPath) {
                configureCell(cell, at: indexPath)
            }
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        default:
            break
        }
    }
}


