//
//  ViewController.swift
//  Project1
//
//  Created by Hassan Sohail Dar on 15/8/2022.
//

import UIKit

class ViewController: UIViewController {

    var pictures = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fn = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fn.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                //this is a pictrure to load
                pictures.append(item)
            }
        }
        print(pictures)

    }


}

