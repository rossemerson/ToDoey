//
//  ViewController.swift
//  ToDoey
//
//  Created by Ross Emerson on 27/05/2019.
//  Copyright © 2019 Ross Emerson. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    let itemArray = ["Raod Rage", "Mad Max", "Kill Bill"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    
    
}

