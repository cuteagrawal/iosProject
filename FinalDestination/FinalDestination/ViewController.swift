//
//  ViewController.swift
//  FinalDestination
//
//  Created by Cute Agrawal on 2024-03-31.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        TwitterService.shared.generateTweet(for: "test"){ success in
            if success{
                print("Tweeted")
            } else{
                print("faied")
            }
        }
    }


}

