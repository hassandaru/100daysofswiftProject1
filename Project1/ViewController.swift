//
//  ViewController.swift
//  Project1
//
//  Created by Hassan Sohail Dar on 15/8/2022.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [String]()
    var counterImageOpened = 0 {
        didSet {
            let jsonEncoder = JSONEncoder()
            if let savedData = try? jsonEncoder.encode(counterImageOpened) {
                let defaults = UserDefaults.standard
                defaults.set(savedData, forKey: "numberOfTimesImageOpened")
            } else {
                print("Failed to save number of times image opened.")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        fillPicturesArray()
        
        let defaults = UserDefaults.standard
        
        if let imagesOpened = defaults.object(forKey: "numberOfTimesImageOpened") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                counterImageOpened = try jsonDecoder.decode(Int.self, from: imagesOpened)
            } catch {
                print("failed to load value")
            }
        }
        print("number of times = \(counterImageOpened)")
    }
    
    @objc func fillPicturesArray() {
        let fn = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fn.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                //this is a pictrure to load
                pictures.append(item)
            }
        }

        pictures.sort()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }

    override func  tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
            cell.textLabel?.text = pictures[indexPath.row]
            return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // 2: success! Set its selectedImage property
            vc.selectedImage = pictures[indexPath.row]
            vc.location = indexPath.row
            vc.count = pictures.count
            counterImageOpened += 1
            // 3: now push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

