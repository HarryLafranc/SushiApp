//
//  ViewController.swift
//  Sushi
//
//  Created by Guillaume Lafranceschina on 26/11/2016.
//  Copyright © 2016 Guillaume Lafranceschina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var labelFeedback: UILabel!
    
    var token:String? = nil
    let url = URL(string: "https://sushi.cest.party/update")
    
    @IBAction func clickUpdateButton(_ sender: UIButton) {
        print("Update click")
        
        // Each time we click, resets the label
        labelFeedback.text = ""
        
        var request = URLRequest(url: url!)
        // Add the header
        request.setValue(self.token!, forHTTPHeaderField: "harrytoken")
        // Debug header so we don't reset the timer every time
        //request.setValue("true", forHTTPHeaderField: "debug")
        
        // Make the call
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            // In case of error
            guard error == nil else {
                print(error!)
                return
            }
            
            // If we don't have any data
            guard let data = data else {
                print("Data is empty")
                return
            }
            
            // Aaaand proccessing part
            // Maybe I could do a case here ?
            let result = String(data: data, encoding: .utf8)
            
            DispatchQueue.main.async {
                if result == "success" {
                    self.labelFeedback.text = "Timer updated !"
                }
                if result == "forbidden" {
                    self.labelFeedback.text = "Forbidden error"
                }
                if result == "error" {
                    self.labelFeedback.text = "Node error"
                }
            }
        }
        
        task.resume()
    }
    
    override func viewDidLoad() {
        // Reading the config (just a simple plist with a dictionnary)
        let path = Bundle.main.path(forResource: "Config", ofType: "plist")
        let dic = NSDictionary(contentsOfFile: path!)
        
        self.token = dic?["token"] as! String?
        super.viewDidLoad()
    }


}

