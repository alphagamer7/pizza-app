//
//  ViewController.swift
//  thecatapi
//
//  Created by test on 2022-10-18.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    var dogBreeds: [[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        DogAPI_Helper.fetchDogs{ response in
            switch response{
            case let .success(dogBreeds):
                let sortedDogBreeds = dogBreeds.sorted(by: { $0.0 < $1.0 })
                var subBreeds: [String]
                for (key, value) in sortedDogBreeds {
                    subBreeds = []
                    subBreeds = value
                    subBreeds.insert(key, at: 0)
                    self.dogBreeds.append(subBreeds)
                }
            case let .failure(error):
                print(error)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
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
        return dogBreeds.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dogbreed", for: indexPath)

        // Configure the cell...
        let mainBreed = dogBreeds[indexPath.row][0]
        if dogBreeds[indexPath.row].count < 2 {
            cell.textLabel?.text = mainBreed
        } else {
            let curBreeds = dogBreeds[indexPath.row]
            let from1 = curBreeds.index(after: curBreeds.startIndex)
            let toEnd = curBreeds.endIndex
            let subBreeds = curBreeds[from1..<toEnd].map { String($0) }
                .joined(separator: ", ")
            
            let breedsToShow = "\(mainBreed): \(subBreeds)"
            let myMutableString = NSMutableAttributedString(string: breedsToShow)
            myMutableString.addAttribute(
                NSAttributedString.Key.foregroundColor,
                value: UIColor.gray,
                range: NSRange(location:mainBreed.count + 2,length:subBreeds.count)
            )
            cell.textLabel?.attributedText = myMutableString
        }

        return cell
    }


}

