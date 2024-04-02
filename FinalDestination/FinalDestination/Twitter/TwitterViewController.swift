//
//  TwitterViewController.swift
//  FinalDestination
//
//  Created by Cute Agrawal on 2024-03-31.
//

import UIKit

class TwitterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var tfTweet : UITextField!
    
    @IBAction func sendTweet (sender: UIButton){
        
        var tweetData = tfTweet.text
        
        TwitterService.shared.generateTweet(for: tweetData ?? "I need to sleep"){ success in
            if success{
                print("Tweeted")
                
                let tweetInst : TweetData = .init()
                tweetInst.initWithData(theRow: 0, theTweet: self.tfTweet.text!)
                
                
                let mainDelegate = UIApplication.shared.delegate as! AppDelegate
                
                let returnCode : Bool = mainDelegate.inserIntoDatabase(tweetInstance: tweetInst)
                
                var returnMsg = "Tweet Added"
                
                if returnCode == false{
                    returnMsg = "Tweet Add Failed"
                }
                
                
                
                
            } else{
                print("failed")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
