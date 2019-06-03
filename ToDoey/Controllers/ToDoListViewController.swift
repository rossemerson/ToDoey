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
    
    //create an object to hold the filepath for the app
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("items.plist")
    // if other plist files need to be creates then new objects can be created with a new plist identifier. These can be encoded and decoded when needed.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath!)
        
        //call the decode method model
        loadItems()
        
    }

    //MARK: TableView DataSource Methods
    
    // Declare cellForRowAt indexPath
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        //toggle the checkmark to display or hide when the cell is selected using a ternary
        cell.accessoryType = itemArray[indexPath.row].done == true ? .checkmark : .none

        return cell
    }
    
    // Declare numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // MARK: TableView Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        //toggle the checkmark for the tableview item data and add it to the array in the pList file. Reload the tableview
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()

        // code to make the selected row of the UI flask temporarily rather than premenantly highlight the row
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
            // save the appended items to the plist calling the saveItems model method
            self.saveItems()
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
    
    //Mark: Model Manipulation methods
    
    //create a method to update the pList file to reflect any changes made
    func saveItems() {
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
            
        } catch {
            print("Error encoding item array, \(error)")
        }
        self.tableView.reloadData()
    }
    
    //create a decode method to call the encoded data from the plist file
    func loadItems () {
        if let data = try? Data (contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("error decoding the item array \(error)")
            }
        }
    }
}

