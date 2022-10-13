//
//  ViewController.swift
//  ApolloToDoList
//
//  Created by Arseniy Apollonov on 10.10.2022.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var cellArray = [Item]()
    
    //Add File Manager that save our ToDoList Information
    var dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        cell.accessoryType = item.done ? .checkmark : .none
        return cell 
    }
    
    //MARK: - tableView delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        cellArray[indexPath.row].done = !cellArray[indexPath.row].done
        
        self.saveItems()
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new To-Do item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) {
            (action) in
            let newItem = Item()
            newItem.title = textField.text!
            self.cellArray.append(newItem)
            
            //Add our Array to Data of Phone..
            self.saveItems()
            
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
    
    //MARK: - Model Manipulation methods
    
    func saveItems(){
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(cellArray)
            try data.write(to: dataFilePath!)
        } catch {
            print(error)
        }
    }

}

