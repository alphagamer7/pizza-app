//
//  ToppingTableViewController.swift
// pizza app
//
//  Created by the alpha team (Athif, Shubham & Shivam)
//

import UIKit

class ToppingTableViewController: UITableViewController {
    
    let TOPPINGS = [
        NSLocalizedString("Pepperoni", comment: "A Pepperoni pizza topping"),
        NSLocalizedString("Bacon", comment: "A Bacon pizza topping"),
        NSLocalizedString("Mushroom", comment: "A Mushroom pizza topping"),
        NSLocalizedString("Tomatoes", comment: "A Tomatoes pizza topping"),
        NSLocalizedString("Olives", comment: "An Olives pizza topping"),
        NSLocalizedString("Green Peppers", comment: "A Green Peppers pizza topping"),
        NSLocalizedString("Onions", comment: "An Onion pizza topping"),
        NSLocalizedString("Jalapenos", comment: "A Jalapenos pizza topping")
    ]
   
    
    /*/*this is a comment */*/
    /* this /* is /* a /* comment */*/*/*/
    let SELECTED_ROW_COLOR = UIColor(hue: 0.0056, saturation: 0.57, brightness: 0.97, alpha: 1.0) /* #f96e69 */

    let DEFAULT_ROW_COLOR = UIColor(white: 0, alpha: 0)
    var toppingSelectionStatuses = Array(repeating: false, count: 8)
    
//    var historyOrderList: HistoryOrderList!
//    var selectedOrderIndex: Int?
    var isEditMode: Bool = false
    
    var historyOrderToModify: HistoryOrder!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        // Save selected topping of history order (to update on UITableView below in viewWillLayoutSubviews())
        if let order = historyOrderToModify, isEditMode {
            let selectedToppingList = order.toppings
            
            if selectedToppingList.count > 0 {
                for (index, tp) in TOPPINGS.enumerated() {
                    if selectedToppingList.contains(tp) {
                        // Init the status list
                        toppingSelectionStatuses[index] = true
                    }
                }
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        // Highlight selected rows in this lifecycle method, after subviews
        // are about layouting, to prevent warning of layouting this
        // UITableView's visible cells while it has not been added
        // to the window view hierarchy yet
        var indexPath: IndexPath!
        for (index, isSelected) in toppingSelectionStatuses.enumerated() {
            if isSelected {
                indexPath = IndexPath(row: index, section: 0)
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                tableView.delegate?.tableView!(self.tableView, didSelectRowAt: indexPath)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TOPPINGS.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topping", for: indexPath)

        // Configure the cell...
        let currentToppingRow = TOPPINGS[indexPath.row]
        cell.textLabel!.text = currentToppingRow


        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedCell = tableView.cellForRow(at: indexPath)
        else { return }
        selectedCell.contentView.backgroundColor = SELECTED_ROW_COLOR
        
        toppingSelectionStatuses[indexPath.row] = true
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let selectedCell = tableView.cellForRow(at: indexPath)
        else { return }
        selectedCell.contentView.backgroundColor = DEFAULT_ROW_COLOR
        
        toppingSelectionStatuses[indexPath.row] = false
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        guard let selectedCell = tableView.cellForRow(at: indexPath)
        else { return nil }
        
        if toppingSelectionStatuses[indexPath.row] {
            tableView.deselectRow(at: indexPath, animated: false)
            toppingSelectionStatuses[indexPath.row] = false
            selectedCell.contentView.backgroundColor = DEFAULT_ROW_COLOR
            return nil
        }
        tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        toppingSelectionStatuses[indexPath.row] = true
        selectedCell.contentView.backgroundColor = SELECTED_ROW_COLOR
        return indexPath
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.

        // Update the historyOrderToModify selected toppings to prepare for
        // passing to destination segue below
        if let indexPaths = tableView.indexPathsForSelectedRows {
            var selectedTopping: String!
            historyOrderToModify.toppings = []
            for idx in indexPaths {
                selectedTopping = TOPPINGS[idx.row]
                historyOrderToModify.toppings.append(selectedTopping)
            }
            historyOrderToModify.updateToppingText()
        }
        
        // pass over the historyOrderToModify to the destination (OrderViewController)
        let dst = segue.destination as! OrderViewController
        dst.historyOrderToModify = historyOrderToModify
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "segueFromToppingsToOrder" {
            if let indexPaths = tableView.indexPathsForSelectedRows {
                if indexPaths.count == 0 {
                    return false
                }
            } else {
                return false
            }
        }
        return true
    }

}
