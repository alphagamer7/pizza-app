//
//  HistoryOrderList.swift
//  pizza app
//
//  Created by the alpha team (Athif, Shubham & Shivam)
//

import Foundation

class HistoryOrderList {
    var hisroryOrders: [HistoryOrder] = []
    let historyOrdersURL: URL = {
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentDirectories.first!
        return documentDirectory.appendingPathComponent("hitoryOrders.archive")
    }()
    
    // Load data from archive on History Order List initializing
    init() {
        do {
            let data = try Data(contentsOf: historyOrdersURL)
            hisroryOrders = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! [HistoryOrder]
        } catch let err {
            print(err)
        }
    }
    
    init(autofilled: Bool) {
        // List of customization items
        let toppings = ["Pepperoni", "Bacon", "Mushroom", "Tomatoes", "Olives", "Green Peppers", "Onions", "Jalapenos"]
        var order: HistoryOrder!
        for _ in 1...10 {
            order = HistoryOrder(toppings: toppings)
            order.setOrderInfo("My Name", "My Address", "My City", "My ZipCode")
            addHistoryOrder(order: order)
        }
    }
    
    // Add new history order
    func addHistoryOrder(order: HistoryOrder) {
        if let index = hisroryOrders.firstIndex(where: {$0.id == order.id}) {
            // Order exists => Update data
            hisroryOrders[index] = order
        } else {
            // Order not found => Add new
            hisroryOrders.append(order)
        }
    }
    
    // Remove existing history order
    func removeHistoryOrder(position: Int) {
        hisroryOrders.remove(at: position)
    }
    
    // Archive history orders data to document directory
    func save() {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: hisroryOrders, requiringSecureCoding: false)
            try data.write(to: historyOrdersURL)
        } catch let err {
            print(err)
        }
    }
}
