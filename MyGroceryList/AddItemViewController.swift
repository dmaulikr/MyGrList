//
//  AddItemViewController.swift
//  MyGroceryList
//
//  Created by Ludin on 1/24/17.
//  Copyright © 2017 Ludin. All rights reserved.
//

import UIKit
import CoreData // Need to import core data so as to use entity data

// View controller for adding a new item page
class AddItemViewController: UIViewController
{
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitButton(_ sender: Any)
    {
        // If text field is empty just return and dont add to list
        guard !textField.text!.isEmpty else {
            return
        }
        
        // Establish core data connection
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // Establish entity connection and view/save its contents
        let item = Item(context: context)
        item.name = textField.text!
        
        // Save the core data
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        // Once done with data pop back to the View Controller/Table View
        navigationController!.popViewController(animated: true)
    }
    
    
    // Function to close keyboard when touched anywhere else on screen
    override func touchesBegan(_: Set<UITouch>, with: UIEvent?)
    {
        textField.resignFirstResponder()
    }
}
