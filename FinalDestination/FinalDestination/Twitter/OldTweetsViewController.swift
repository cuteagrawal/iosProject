//
//  OldTweetsViewController.swift
//  FinalDestination
//
//  Created by Cute Agrawal on 2024-04-01.
//

import UIKit

/*
 * This View Controller displays old tweets made by the user in a table. Once the user makes a new
 * Tweet, it shows up at the end of the list.
 *
 * For future appliction and expansion, I have planned to work on providing functionality
 * to edit the tweet or delete it (On X(previously twitter))
 */


class OldTweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // Connection to the App Delegate
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // Table video declaration
    @IBOutlet var tblVe: UITableView!
    
    
    // View Did Load - Calling read data that loads previous tweets
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let backgroundImage = UIImageView(image: UIImage(named: "TweetBackground.jpg"))
            backgroundImage.contentMode = .scaleAspectFill
            self.tblVe.backgroundView = backgroundImage
        
        
        // read Data loads previous tweets
        mainDelegate.readDataFromDatabase()
    }
    
    
    // Number of rows is the amount of tweets in the array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainDelegate.tweetArr.count
    }
    
    // Height of the table cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    // Loads the Tweets in to table. Primary lable is the tweet previously made
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableCell : SiteCellTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SiteCellTableViewCell ?? SiteCellTableViewCell(style: .default, reuseIdentifier: "cell")
        
        let rowNum = indexPath.row
        tableCell.primaryLabel.text = mainDelegate.tweetArr[indexPath.row].tweet
        
        tableCell.accessoryType = .disclosureIndicator
        
        return tableCell
    }
    
    
    // Added for future expansion of the code in six months. like deleting tweets and editing tweet
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    // Allows user to return back to Old Tweet page from new tweet page
    @IBAction func unwindToOldTweetsView(sender : UIStoryboardSegue)
    {
    // typically empty unless special code needed
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
