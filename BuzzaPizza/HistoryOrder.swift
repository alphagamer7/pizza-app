//
//  HistoryOrder.swift
//  BuzzaPizza
//
//  Created by Tri Le on 4/20/22.
//

import Foundation

class HistoryOrder : NSObject, NSCoding {
    var id = UUID().uuidString
    var toppings: [String] = []
    var name = ""
    var address = ""
    var city = ""
    var zipCode = ""
    var toppingText = ""
    
    override init() {}
    
    init(toppings: [String]) {
        super.init()
        self.toppings = toppings
        updateToppingText()
    }

    func updateToppingText() {
        // Convert from array list of toppings to a string with comma-separated toppings
        // ["Mozzarella", "BBQ Sauce", "Tomato"] => "Mozzarella, BBQ Sauce, and Tomato"
        var toppingsToConvert = toppings;
        if (toppingsToConvert.count > 0) {
            let firstTopping = toppingsToConvert[0];
            let lastTopping = toppingsToConvert[toppingsToConvert.count - 1];
            
            let from1 = firstTopping.index(firstTopping.startIndex, offsetBy: 0)
            let to1 = firstTopping.index(firstTopping.startIndex, offsetBy: 1)
            let from2 = firstTopping.index(after: firstTopping.startIndex)
            let to2 = firstTopping.endIndex
            // Capitalize first letter of first topping in the list
            toppingsToConvert[0] = String(format: "%@%@", String(firstTopping[from1..<to1]).uppercased(), String(firstTopping[from2..<to2]))
            // Add "and" as a linking word to the last topping in the list for a more natural sentence.
            toppingsToConvert[toppingsToConvert.count - 1] = String(format: "and %@.", lastTopping);

            self.toppingText = toppingsToConvert.joined(separator: ", ")
        }
    }
    
    func setOrderInfo(_ name: String, _ address: String, _ city: String, _ zipCode: String) {
        self.name = name
        self.address = address
        self.city = city
        self.zipCode = zipCode
    }

    // Encode for archiving item data
    func encode(with coder: NSCoder) {
        coder.encode(toppings, forKey: "toppings")
        coder.encode(name, forKey: "name")
        coder.encode(address, forKey: "address")
        coder.encode(city, forKey: "city")
        coder.encode(zipCode, forKey: "zipCode")
    }

    // Decode item data from archive
    required init?(coder: NSCoder) {
        toppings = coder.decodeObject(forKey: "toppings") as! [String]
        name = coder.decodeObject(forKey: "name") as! String
        address = coder.decodeObject(forKey: "address") as! String
        city = coder.decodeObject(forKey: "city") as! String
        zipCode = coder.decodeObject(forKey: "zipCode") as! String
        
        super.init()
        
        updateToppingText()
    }
}
