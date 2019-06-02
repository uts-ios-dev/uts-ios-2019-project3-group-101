//
//  AddViewController.swift
//  GroceryList
//
//  Created by Divraj Singh on 2/6/19.
//  Copyright © 2019 UTS. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController {

    // MARK: Properties
    
    var managedContext : NSManagedObjectContext!
    
    // MARK: Outlets

    @IBOutlet var itemTv: UITextView!
    @IBOutlet var doneBtn: UIButton!
    @IBOutlet weak var bottomContraint: NSLayoutConstraint!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(with:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
//        itemTv.becomeFirstResponder()
    }
    
    // MARK: Actions
    
    @objc func keyboardWillShow(with notification: Notification) {
        let key = "UIKeyboardFrameEndUserInfoKey"
        guard let keyboardFrame = notification.userInfo?[key] as? NSValue else {return}
        
        let keyboardHeight = keyboardFrame.cgRectValue.height + 16
        
        bottomContraint.constant = keyboardHeight
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    fileprivate func dismissAndResign() {
        itemTv.resignFirstResponder()
        dismiss(animated: true)
    }
    
    @IBAction func handleCancel(_ sender: Any) {
        dismissAndResign()
    }
    
    @IBAction func handleAdd(_ sender: Any) {
        
        guard let groceryItem = itemTv.text else { return }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.saveItem(item: groceryItem)
        dismissAndResign()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AddViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if doneBtn.isHidden {
            itemTv.text.removeAll()
            itemTv.textColor = .white
            
            doneBtn.isHidden = false
            
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
            }
        }
    }
//    func textViewDidChangeSelection(_ textView: UITextView) {
//        if doneBtn.isHidden {
//            itemTv.text.removeAll()
//            itemTv.textColor = .white
//
//            doneBtn.isHidden = false
//
//            UIView.animate(withDuration: 0.2) {
//                self.view.layoutIfNeeded()
//            }
//        }
//    }
}
