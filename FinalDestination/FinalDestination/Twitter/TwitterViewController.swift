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
        
        if(tfTweet.text!.isEmpty == true || tfTweet.text!.count > 23){
            
            let alertController = UIAlertController(title: "Error", message: "Please keep the character limit between 1 & 23", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel)
            
            alertController.addAction(cancelAction)
            present(alertController, animated: true)
            
        }else{
            
            var tweetData = tfTweet.text
            
            TwitterService.shared.generateTweet(for: tweetData ?? "I need to sleep"){ success in
                if success{
                    print("Tweeted")
                    
                    let tweetInst : TweetData = .init()
                    tweetInst.initWithData(theRow: 0, theTweet: self.tfTweet.text!)
                    
                    
                    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
                    let returnCode : Bool = mainDelegate.inserIntoDatabase(tweetInstance: tweetInst)
                    
                    
                    let alertController = UIAlertController(title: "Tweeted Succesfully", message: "You tweeted succesfully.", preferredStyle: .alert)
                    
                    
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
