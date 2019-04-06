//
//  CompetitionListViewController.swift
//  JudgementDay
//
//  Created by Mackenzie Hampel on 4/4/19.
//  Copyright © 2019 Weber State. All rights reserved.
//
import UIKit
import Foundation
class CompetitionListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var competitions = [ "A", "B"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // competitions = [ "A", "B"]
        
        
    }
    @IBAction func didSelectBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return competitions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = competitions[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: user selects row and then maybe an alert view popsup and say would you like to register as a competitior a judge or nevermind
        let alertController = UIAlertController(title: title, message: "How would you like to register for this competition?", preferredStyle:UIAlertController.Style.alert)
        
        alertController.addAction(UIAlertAction(title: "As Judge", style: UIAlertAction.Style.default)
        { action -> Void in
            // Put your code here //registers user as judge for that competition at that indexpath.row
        })
        
        alertController.addAction(UIAlertAction(title: "As Competitor", style: UIAlertAction.Style.default)
        { action -> Void in
            // Put your code here //registers user as competitor for that competition at that indexpath.row
        })
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default)
        { action -> Void in
            // Put your code here //does nothing dismiss alert
        })
        self.present(alertController, animated: true, completion: nil)

        
    }
    //TODO: return all competitions
    
}
