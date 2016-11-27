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
    
    let url = URL(string: "https://sushi.cest.party/update")
    
    @IBAction func clickUpdateButton(_ sender: UIButton) {
        print("Update click")
        
        // Each time we click, resets the label
        labelFeedback.text = ""
        
        var request = URLRequest(url: url!)
        // Add the header
        request.setValue("4999f3aab0b120ad5cfad6c44e8cdbdaddadee69ec3b6939b42963d85a57538e", forHTTPHeaderField: "harrytoken")
        // Debug header so we don't reset the timer every time
        request.setValue("true", forHTTPHeaderField: "debug")
        
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
            let result = String(data: data, encoding: .utf8)
            print("Result -- ", result!)
            print("Response -- ", response!)
        }
        
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

