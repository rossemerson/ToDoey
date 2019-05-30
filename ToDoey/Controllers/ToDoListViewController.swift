//
//  ViewController.swift
//  ToDoey
//
//  Created by Ross Emerson on 27/05/2019.
//  Copyright © 2019 Ross Emerson. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    //create the array from Item class objects
    var itemArray = [Item]()
    //create an object to hold access to our userDefaults persistant data
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //create a property that uses the Item Class to hold a new item object (of type Item).
        let newItem = Item()
        //create the reference object
        newItem.title = "Road Rage"
        //create the code to append the object to the Array
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Kill Bill"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Fat Sam"
        itemArray.append(newItem3)
        
        //check the userDefaults array to see if anything is stored locally in the pList file. if so this is returned as the array.
//        if let item = defaults.array(forKey: "ToDoListArray") as? [String]{
//            itemArray = item
//        }
    }

    //MARK: TableView DataSource Methods
    
    // Declare cellForRowAt indexPath
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        //toggle the checkmark to display or hide when the cell is selected
        if itemArray[indexPath.row].done == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    // Declare numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // MARK: TableView Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.reloadData()

        // code to make the selected row of teh UI flask temporarily rather than premenantly highlight the row
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: Add New Items
    
    // Bar Button Pressed UIAction
    @IBAction func barButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Lets add an item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (alert) in
            // add code to determine what happens once the user presses the UIAction add button
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
        }
        //Create the Label Text field element in the UI with a placeholder
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new item"
            textField = alertTextField
        }
        //Initialise the UI Controller popup
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

