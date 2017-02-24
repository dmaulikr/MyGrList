//
//  ViewController.swift
//  MyGroceryList
//
//  Created by Ludin on 1/24/17.
//  Copyright © 2017 Ludin. All rights reserved.
//

import UIKit
import CoreData

// View controller for table view list
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    // Establish connection to table view
    @IBOutlet weak var tableView: UITableView!
    
    // Create array to organize items
    var items : [Item] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        // Navigation bar color edits
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        // Get the data from the core data
        getData()
        
        //Reload the table view
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // Want to return the number of rows being the item count
        return items.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell()
        
        // Get that item from our array and put it in the cell of the table view
        let item = items[indexPath.row]
        cell.textLabel?.text = item.name!
        
        // When cell selected show no color
        cell.selectionStyle = .none
        
        return cell
    }
    
    
    func getData()
    {
        // Function to fetch the data
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // Try-catch block ensures we properly fetch the data to the items array
        do {
            items = try context.fetch(Item.fetchRequest())
        }
        
        catch {
            print("Fetching failed! :(")
        }
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        // Function for deleting by a slide to the left
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // If user slides to the left of an item in the table view
        if editingStyle == .delete
        {
            // Get the item from our items array, delete it entirely, save it, update the table view
            let item = items[indexPath.row]
            context.delete(item)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            // Try-catch block ensures we properly fetch/update to the data to the items array
            do {
                items = try context.fetch(Item.fetchRequest())
            }
                
            catch {
                print("Fetching failed! :(")
            }
        }
        
        // Finally refresh the table view
        tableView.reloadData()
    }

    
    @IBAction func TrashButtonAction(_ sender: Any) {
        // Delete from core data
        
        // Remove items from array
        items.removeAll()
        
        tableView.reloadData()
    }
}
