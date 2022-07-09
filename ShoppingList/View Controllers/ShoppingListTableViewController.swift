//
//  ShoppingListTableViewController.swift
//  ShoppingList
//
//  Created by Marina Basaeva on 7/9/22.
//

import UIKit

class ShoppingListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ItemController.shared.loadFromPersistenceStore()
    }

    // Actions
    @IBAction func addButtonClicked(_ sender: Any) {

        let alertController = UIAlertController(title: "Add Item", message: "Please add an item to your shopping list", preferredStyle: .alert)
        alertController.addTextField() { textField in
                textField.placeholder = "What do you need from the store?"
            }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let addAction = UIAlertAction(title: "Add", style: .default, handler: {_ in
            let textField = alertController.textFields![0]
            ItemController.shared.addItem(name: textField.text!)
            self.tableView.reloadData()
        })

        alertController.addAction(cancelAction)
        alertController.addAction(addAction)
        present(alertController,animated: true, completion: nil)
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemController.shared.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ItemTableViewCell else {return UITableViewCell()}
        let item = ItemController.shared.items[indexPath.row]
        cell.delegate = self
        cell.item = item
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let itemToDelete = ItemController.shared.items[indexPath.row]
            ItemController.shared.delete(item: itemToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

} // End of class

extension ShoppingListTableViewController: ItemCompletionDelegate {
    func itemCellButtonTapped(_ sender: ItemTableViewCell) {
        guard let item = sender.item else {return}
        ItemController.shared.toggleIsComplete(item: item)
        sender.updateViews()
    }
} // End of extension
