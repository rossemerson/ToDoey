//
//  ViewController.swift
//  ToDoey
//
//  Created by Ross Emerson on 27/05/2019.
//  Copyright © 2019 Ross Emerson. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = ["Raod Rage", "Mad Max", "Kill Bill"]
    //create an object to hold access to our userDefaults persistant data
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //check the userDefaults array to see if anything is stored locally in the pList file. if so this is returned as the array.
        if let item = defaults.array(forKey: "ToDoListArray") as? [String]{
            itemArray = item
        }
    }

    //MARK: TableView DataSource Methods
    
    // Declare cellForRowAt indexPath
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    // Declare numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // MARK: TableView Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])

        //toggle the checkmark to display or hide when the cell is selected
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        // code to flash the selected row rather than highlight the row
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: Add New Items
    
    // Bar Button Pressed UIAction
    @IBAction func barButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Lets add an item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (alert) in
            // add code to determine what happens once the user presses the UIAction add button
            self.itemArray.append(textField.text!)
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

