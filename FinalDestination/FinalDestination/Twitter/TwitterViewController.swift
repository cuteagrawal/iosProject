//
//  TwitterViewController.swift
//  FinalDestination
//
//  Created by Cute Agrawal on 2024-03-31.
//

import UIKit

/*
 * This view controller handles the new tweets.
 * When the user tweets, it is checked if the text field is not empty and the text is under
 * 23 characters. The text limit has been imposed as for the assignment, I don't see the end user
 * to be making a longer tweet.
 */

class TwitterViewController: UIViewController, UITextFieldDelegate {

    // New tweet text field
    @IBOutlet var tfTweet : UITextField!
    
    // this checks the tweet size (between 1 to 23 characters)
    @IBAction func sendTweet (sender: UIButton){
        
        // shows an alert if the user sends an empty twet or super long tweet
        if(tfTweet.text!.isEmpty == true || tfTweet.text!.count > 23){
            
            let alertController = UIAlertController(title: "Error", message: "Please keep the character limit between 1 & 23", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel)
            
            alertController.addAction(cancelAction)
            present(alertController, animated: true)
            
        }else{
            
            // loads tweet string in a variable
            var tweetData = tfTweet.text
            
            // if null default string is used
            TwitterService.shared.generateTweet(for: tweetData ?? "I need to sleep"){ success in
                if success{
                    print("Tweeted")
                    
                    let tweetInst : TweetData = .init()
                    tweetInst.initWithData(theRow: 0, theTweet: self.tfTweet.text!)
                    
                    // connection to App Delegate
                    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
                    let returnCode : Bool = mainDelegate.inserIntoDatabase(tweetInstance: tweetInst)
                    
                    // Alerts the user that the tweet was successfull
                    let alertController = UIAlertController(title: "Tweeted Succesfully", message: "You tweeted succesfully.", preferredStyle: .alert)
                    
                    // takes them back to home page
                    let yesAction = UIAlertAction(title: "Navigate to the Home Page", style:.default){_ in
                        
                        self.performSegue(withIdentifier: "BackToHome", sender: self)
                    }
                    
                    alertController.addAction(yesAction)
                    self.present(alertController, animated: true)
                    
                    
                } else{
                    print("failed")
                }
                
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // returns textfield (keyboard go back)
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
