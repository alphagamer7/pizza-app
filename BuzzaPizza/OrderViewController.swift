//
//  OrderViewController.swift
//  BuzzaPizza
//
//  Created by Tri Le on 4/20/22.
//

import UIKit

class OrderViewController: UIViewController {

    var historyOrderToModify: HistoryOrder!

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var zipCodeField: UITextField!

    // Hide red border color on editing
    @IBAction func fieldEditingChanged(_ sender: UITextField) {
        sender.layer.borderWidth = 0
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Fill selected order data into form
        if let order = historyOrderToModify {
            nameField.text = order.name
            addressField.text = order.address
            cityField.text = order.city
            zipCodeField.text = order.zipCode
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Save entered text before segueing either:
        // + from this scene back to Toppings scene on clicking Back button
        // + or from this scene back to Home root scene on clicking Save button
        if let order = historyOrderToModify {
            order.setOrderInfo(
                nameField.text!,
                addressField.text!,
                cityField.text!,
                zipCodeField.text!
            )
        }
    }
    
    // Handle clicking Save button
    @IBAction func save(_ sender: Any) {
        let name = nameField.text!
        let address = addressField.text!
        let city = cityField.text!
        let zipCode = zipCodeField.text!

        // All Fields are required to add or update history order
        if !name.isEmpty && !address.isEmpty && !city.isEmpty && !zipCode.isEmpty {
            // Go back to Home scene
            self.performSegue(withIdentifier: "unwindFromOrderToHome", sender: self)

            return
        }
        // Only show warning in red color if field is not focused
        if name.isEmpty && !nameField.isFocused {
            nameField.layer.borderColor = UIColor.systemRed.cgColor
            nameField.layer.borderWidth = 1
        }
        // Only show warning in red color if field is not focused
        if address.isEmpty && !addressField.isFocused {
            addressField.layer.borderColor = UIColor.systemRed.cgColor
            addressField.layer.borderWidth = 1
        }
        // Only show warning in red color if field is not focused
        if city.isEmpty && !cityField.isFocused {
            cityField.layer.borderColor = UIColor.systemRed.cgColor
            cityField.layer.borderWidth = 1
        }
        // Only show warning in red color if field is not focused
        if zipCode.isEmpty && !zipCodeField.isFocused {
            zipCodeField.layer.borderColor = UIColor.systemRed.cgColor
            zipCodeField.layer.borderWidth = 1
        }
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
