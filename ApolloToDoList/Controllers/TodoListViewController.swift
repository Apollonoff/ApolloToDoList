//
//  ViewController.swift
//  ApolloToDoList
//
//  Created by Arseniy Apollonov on 10.10.2022.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var cellArray = [Item]()
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item]{
            cellArray = items
        }
        //test model
        let newItem = Item()
        newItem.title = "find solution"
        cellArray.append(newItem)
    }

    //MARK: - tableview features
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = cellArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        if item.done == true{
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell 
    }
    
    //MARK: - tableView delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        cellArray[indexPath.row].done = !cellArray[indexPath.row].done
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new To-Do item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) {
            (action) in
            //Add new item at zero position of Array that improve list cell to look better
            let newItem = Item()
            newItem.title = textField.text!
            self.cellArray.append(newItem)
            
            //Add our Array to Data of Phone..
            self.defaults.set(self.cellArray, forKey: "ToDoListArray")
            //reload data
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        present(alert, animated: true)
        
    }

}

