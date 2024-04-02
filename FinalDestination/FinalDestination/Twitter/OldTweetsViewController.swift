//
//  OldTweetsViewController.swift
//  FinalDestination
//
//  Created by Cute Agrawal on 2024-04-01.
//

import UIKit

class OldTweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet var tblVe: UITableView!
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        mainDelegate.readDataFromDatabase()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainDelegate.tweetArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableCell : SiteCellTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SiteCellTableViewCell ?? SiteCellTableViewCell(style: .default, reuseIdentifier: "cell")
        
        
        
        let rowNum = indexPath.row
        tableCell.primaryLabel.text = mainDelegate.tweetArr[indexPath.row].tweet
        
        tableCell.accessoryType = .disclosureIndicator
        
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
    
    
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
