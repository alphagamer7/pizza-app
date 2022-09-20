//
//  ViewController.swift
//  swapi
//
//  Created by test on 2022-09-20.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        SWAPI_Helper.fetchDir();
    }
}


