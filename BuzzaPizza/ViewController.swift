//
//  ViewController.swift
//  BuzzaPizza
//
//  Created by Tri Le on 4/20/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func toggleEditMode(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
            sender.title = NSLocalizedString("Edit", comment: "Button to enable editing table rows")   // reset button title to edit when done editing
        } else {
            tableView.setEditing(true, animated: true)
            sender.title = NSLocalizedString("Done", comment: "Button to disable editing table rows")   // change button title to done when user click to enter edit mode
        }
    }
    var historyOrderList: HistoryOrderList!
    var historyOrderToModify: HistoryOrder!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // Reload table view data after go back from order scene
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return historyOrderList.hisroryOrders.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "order", for: indexPath)

        // Configure the cell...
        cell.textLabel!.text = historyOrderList.hisroryOrders[indexPath.row].toppingText
        // Enable text wrapping on table cells
        cell.textLabel!.numberOfLines = 0
        cell.textLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "edit", sender: self)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            historyOrderList.removeHistoryOrder(position: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        // pass over the historyOrderList to the destination (ToppingTableViewController) and then (OrderViewController) afterward
        let dst = segue.destination as! ToppingTableViewController
        
        // pass over the current mode and selected row index (if any) to the destination (ToppingTableViewController)
        if segue.identifier == "edit" {
            dst.isEditMode = true
            if let selectedRow = tableView.indexPathForSelectedRow?.row {
                dst.historyOrderToModify = historyOrderList.hisroryOrders[selectedRow]
            }
        } else if segue.identifier == "add" {
            dst.isEditMode = false
            dst.historyOrderToModify = HistoryOrder()
        }
    }
    
    // Segue OrderViewController -> this Root ViewController
    @IBAction func unwindSegue(for unwindSegue: UIStoryboardSegue,
                               towards subsequentVC: UIViewController) {
        if let srcViewController = unwindSegue.source as? OrderViewController {
            self.historyOrderToModify = srcViewController.historyOrderToModify

            // Delegate to addHistoryOrder() for checking whether to update or add new data
            historyOrderList.addHistoryOrder(order: historyOrderToModify)
        }
    }
}

