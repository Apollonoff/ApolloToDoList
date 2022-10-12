//
//  ViewController.swift
//  ApolloToDoList
//
//  Created by Arseniy Apollonov on 10.10.2022.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var cellArray: [String] = ["clean teeth", "take a bath", "learn ios development"]
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = defaults.array(forKey: "ToDoListArray") as? [String]{
            cellArray = items
        }
    }

    //MARK: - tableview features
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = cellArray[indexPath.row]
        return cell 
    }
    
    //MARK: - tableView delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        print(cellArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new To-Do item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) {
            (action) in
            //Add new item at zero position of Array that improve list cell to look better
            self.cellArray.insert(textField.text!, at: 0)
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

